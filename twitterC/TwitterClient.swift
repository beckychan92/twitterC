//
//  TwitterClient.swift
//  twitter
//
//  Created by Becky Chan on 2/23/17.
//  Copyright © 2017 Becky Chan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "lupvuvmit3BhzNaXDZGMeqIfX", consumerSecret: "XMz4gBDrTd2TUYaqiwyu1HS1vA9qQJmYcR4Zk2iPOdkEUjbmsR")
    
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    
    
    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()){
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response:Any?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
            
        }, failure: {
            (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error as NSError)
        })
        
        
    }
    
    //current user
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (NSError) -> () ){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success:{ (task: URLSessionDataTask, response: Any?) in
            let userDictionary = response as? NSDictionary
            let user = User(dictionary: userDictionary! as! Dictionary<String, Any> as NSDictionary)
            
            success(user)
            
            print("name: \(user.name)")
            print("screenname: \(user.screenname)")
            print("profile url: \(user.profileUrl)")
            print("description: \(user.description)")
            
        }, failure: {
            (task: URLSessionDataTask?, error: Error?) in
            failure(error as! NSError)
        })
        
        
    }
    
    func login(success: @escaping () -> (), failure: @escaping (NSError) -> () ){
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
//        TwitterClient.sharedInstance?.deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth") as URL!, scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            
        //register extensions
//        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterC://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
        
            
            
            
            print("got a token!")
            
            //youtube 14:30
            if requestToken != nil {
                let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\((requestToken?.token)!)")!
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            
            }
//            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")
            
            //open allow you to switch out of application to something else. this includes safari, maps, etc. if its http -> safari
//            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            
        }, failure: {(error) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error as! NSError)
        })
        
    
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        
        NotificationCenter.default.post(name: NSNotification.Name(User.userDidLogoutNotification), object: nil)
        //
        //        NotificationCenter.default().postNotification(User.userDidLogoutNotification, object: nil)
    }
    
    
    func handleOpenUrl(url: NSURL){
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: {(accessToken: BDBOAuth1Credential? ) -> Void in
            
            self.currentAccount(success: { (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                
            }, failure: { (error)  -> () in
                self.loginFailure?(error as NSError)
            })
            
            
        }, failure: {(error: Error?) -> Void in
            print(error?.localizedDescription)
            self.loginFailure?(error as! NSError)
        })
        
        
    }
    
}
