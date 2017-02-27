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
    
    
    //single client that you can use throughout the application so you dont need to so you dont need to continue recreating
    
    //create shared instance                //static allows you to directly call the class and shared instance
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "lupvuvmit3BhzNaXDZGMeqIfX", consumerSecret: "XMz4gBDrTd2TUYaqiwyu1HS1vA9qQJmYcR4Zk2iPOdkEUjbmsR")
    
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    
    
    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()){
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response:Any?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            //            for tweet in tweets {
            //                print("\(tweet.text!)")
            //            }
            success(tweets)
            
        }, failure: {
            (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error as NSError)
            //            print("failed!")
        })
        
        
    }
    
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> () ){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success:{ (task: URLSessionDataTask, response: Any?) -> Void in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            //            //better way                                //original (not preferred way)
            //            print("user: \(user.name)")                 //                print("user: \(user)")
            //            print("screenname: \(user.screenname)")     //                print("name: \(user["name"])")
            //            print("profile URL: \(user.profileUrl)")    //                print("screenname: \(user["screen_name"])")
            //            print("description: \(user.tagline)")       //                print("profile URL: \(user["profile_image_url_https"])")
            //                                                        //                print("description: \(user["description"])")
            //
        }, failure: {
            (task: URLSessionDataTask?, error: Error?) -> Void in
            failure(error!)
            //            print("failed!")
            
        })
        
        
    }
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> () ){
        loginSuccess = success
        loginFailure = failure
        
        
        TwitterClient.sharedInstance?.deauthorize()
        
        //register extensions
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            
            print("got a token!")
            
            //youtube 14:30
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")
            
            //open allow you to switch out of application to something else. this includes safari, maps, etc. if its http -> safari
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            
        }) {(Error: Error?) -> Void in
            print("error: \(Error!.localizedDescription)")
            self.loginFailure?(Error as! NSError)
        }
        
        
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

//client?.currentAccount()
//client?.homeTimeLine(success: { (tweets: [Tweet]) in
//    for tweet in tweets {
//        print(tweet.text)
//    }
//}, failure: { (error) in
//    print(error.localizedDescription)
//})


//      Notes
//    let requestToken = BDBOAuth1Credential(queryString: url.query)
//    let twitterClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "lupvuvmit3BhzNaXDZGMeqIfX", consumerSecret: "XMz4gBDrTd2TUYaqiwyu1HS1vA9qQJmYcR4Zk2iPOdkEUjbmsR")
//}









//
////
////  TwitterClient.swift
////  twitterC
////
////  Created by Becky Chan on 2/26/17.
////  Copyright © 2017 Becky Chan. All rights reserved.
////
//
//import UIKit
//import BDBOAuth1Manager
//
//class TwitterClient: BDBOAuth1SessionManager {
//    
//    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "lupvuvmit3BhzNaXDZGMeqIfX", consumerSecret: "XMz4gBDrTd2TUYaqiwyu1HS1vA9qQJmYcR4Zk2iPOdkEUjbmsR")
//        
//        
////        TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "lupvuvmit3BhzNaXDZGMeqIfX", consumerSecret: "XMz4gBDrTd2TUYaqiwyu1HS1vA9qQJmYcR4Zk2iPOdkEUjbmsR")
//    
//    var loginSuccess: (() -> ())?
//    var loginFailure: ((Error) -> ())
//
//    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
//        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: {(task: URLSessionDataTask, response: Any?) in
//            let dictionaries = response as! [NSDictionary]
//            print("i got data")
//            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
//            success(tweets)
//        }, failure: {
//            (task: URLSessionDataTask?, error: Error) in
//            print("not working")
//            failure(error)
//        })
//    }
//    
//    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> () ) {
//        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
//            let userDictionary = response as! NSDictionary
//            let user = User(dictionary: userDictionary as! Dictionary < String, Any> as NSDictionary)
//            
//            success(user)
//        }, failure: {
//            (task: URLSessionDataTask?, error: Error) in
//            failure(error)
//        })
//    
//    }
//    
//    func login(success: @escaping () -> (), failure: @escaping (Error) -> () ) {
//        TwitterClient.sharedInstance?.deauthorize()
//        
//        TwitterClient.sharedInstance?.fetchRequestToken(fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: (string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
//            print("I have a token!")
//            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
//            
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            
//            success()
//        
//        }, failure: {(Error: Error?) -> Void in
//            print("error: \(Error!.localizedDescription)")
//            self.loginFailure?(Error!)
//        }))}
//    
//    func logout(){
//        User.currentUser = nil
//        deauthorize()
//        
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
//    }
//    
//    func handleOpenUrl(url: NSURL){
//        let requestToken = BDBOAuth1Credential(queryString: url.query)
//        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: {(accessToken: BDBOAuth1Credential?) in
//            self.currentAccount(success: {(user: User) -> () in
//                User.currentUser = user
//                self.loginSuccess?()
//            
//            }, failure: { (error: Error) -> () in
//                self.loginFailure(error)
//            })
//            
//        }, failure: { (error: Error?) in
//            print(error?.localizedDescription)
//            self.loginFailure(error!)
//        })
//        
//
//    }
//
//}
