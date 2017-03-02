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
    var retweets_count: Int = 0
    var favoritesCount: Int = 0
    var user: User?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweets_count = (dictionary["retweet_count"] as! Int)
        favoritesCount = (dictionary["favorite_count"] as! Int)
        user = User(dictionary: dictionary)
        
        
        let timestampString = dictionary["created at"] as? String
        
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH: mm:ss Z y"
            
            timestamp = formatter.date(from: timestampString) as Date?
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
