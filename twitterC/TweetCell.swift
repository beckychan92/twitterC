//
//  TweetCell.swift
//  twitterC
//
//  Created by Becky Chan on 2/26/17.
//  Copyright © 2017 Becky Chan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profilephoto: UIImageView!
    @IBOutlet weak var rCount: UILabel!
    @IBOutlet weak var lCount: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var retweetButtonOutlet: UIButton!
    @IBOutlet weak var likeButtonOutlet: UIButton!

    
    
    @IBOutlet weak var timeStamp: UILabel!
    
    var retweeted = false
    var favorited = false
    
//    var user: User! {
//        didSet{
//            profilephoto.setImageWith(user.profileUrl!)
//            nameLabel.text = user.screenname
//            retweetButtonOutlet.setImage(UIImage (named: "retweet_icon"), for: UIControlState.normal)
//            likeButtonOutlet.setImage(UIImage (named: "like_icon"), for: UIControlState.normal)
//        
//        }
//    }
    
    var tweet: Tweet! {
        
        didSet{
            tweetLabel.text = tweet.text
            rCount.text = "\(tweet.retweets_count)"
            lCount.text = "\(tweet.favoritesCount)"
            timeStamp.text = "\(tweet.timestamp)"
            
            if let imageURL = tweet.user?.profileUrl {
                
                profilephoto.setImageWith(imageURL)
            
            }
                
            
            
        
        }
    }
    
    
    @IBAction func retweetButton(_ sender: Any) {
        if retweeted == false {
            retweetButtonOutlet.setImage(UIImage (named: "retweet_icon_blue"), for: UIControlState.normal)
            rCount.text = "\(Int(rCount.text!)! + 1)"
            retweeted = true
        } else {
            retweetButtonOutlet.setImage(UIImage (named: "retweet_icon"), for: UIControlState.normal)
            rCount.text = "\(Int(rCount.text!)! - 1)"
            retweeted = false
        }
    }
    
    
    
    @IBAction func likeButton(_ sender: Any) {
        if favorited == false {
            likeButtonOutlet.setImage(UIImage (named: "like_icon_blue"), for: UIControlState.normal)
            lCount.text = "\(Int(lCount.text!)! + 1)"
            favorited = true
        } else {
            likeButtonOutlet.setImage(UIImage (named: "like_icon"), for: UIControlState.normal)
            lCount.text = "\(Int(lCount.text!)! - 1)"
            favorited = false
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
