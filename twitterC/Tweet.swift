//
//  Tweet.swift
//  twitterC
//
//  Created by Becky Chan on 2/26/17.
//  Copyright © 2017 Becky Chan. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String?
    var timestamp: Date?
    var timestampStr: String?
    var retweets_count: Int = 0
    var favoritesCount: Int = 0
    var user: User?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweets_count = (dictionary["retweet_count"] as! Int)
        favoritesCount = (dictionary["favorite_count"] as! Int)
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        
        
        if let timestampString = dictionary["created_at"] as? String{
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM dd HH:mm:ss ZZZZ yyyy"
            timestamp = formatter.date(from: timestampString)
            timestampStr = formatter.string(from: timestamp!)
        }
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}
