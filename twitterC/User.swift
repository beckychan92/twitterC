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
    var tagline: String?
    var dictionary: NSDictionary?
    static let userDidLogoutNotification = "UserDidLogout"
    static var _currentUser: User?
    
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https" as? String]
        
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString as! String)
        }
        tagline = dictionary["description"] as? String
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? NSData
                
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)}
                }
                return _currentUser
            }
        set(user){
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.object(forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
}
