//
//  User.swift
//  twitterC
//
//  Created by Becky Chan on 2/26/17.
//  Copyright © 2017 Becky Chan. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var backgroundUrl: URL?
    var tagline: String?
    var dictionary: NSDictionary?
    static let userDidLogoutNotification = "UserDidLogout"
    static var _currentUser: User?
    var followers: Int?
    var following: Int?
    var tweetCount: Int?
    
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        print(dictionary)
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        if let profUrl = dictionary["profile_image_url_https"] as? String{
            profileUrl = URL(string: profUrl)
        }
        
        if let backgroundProf = dictionary["profile_background_image_url_https"] as? String{
            backgroundUrl = URL(string: backgroundProf)
        }
        

        
        tagline = dictionary["description"] as? String
        followers = dictionary["followers_count"] as? Int
        following = dictionary["following_count"] as? Int
        tweetCount = dictionary["statuses_count"] as? Int
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
                
                if let userData = userData {
                    print("i found data")
                    if let diction = try? JSONSerialization.jsonObject(with: userData, options: .allowFragments){
                        _currentUser = User(dictionary: diction as! NSDictionary)}
                    }
                }
                return _currentUser
            }
        set(user){
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
}
