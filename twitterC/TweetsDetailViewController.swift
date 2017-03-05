//
//  TweetsDetailViewController.swift
//  twitterC
//
//  Created by Becky Chan on 3/2/17.
//  Copyright © 2017 Becky Chan. All rights reserved.
//

import UIKit

class TweetsDetailViewController: UIViewController {

    
    @IBOutlet weak var profilepix: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCount: UILabel!
    
    var tweet: Tweet!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Tweet"
        tweetLabel.text = tweet.text!
        retweetCount.text = "\(tweet.retweets_count)"
        likeCount.text = "\(tweet.favoritesCount)"
        timeStamp.text = "\(tweet.timestamp)!"
        userName.text = "\(tweet.user!.screenname!)"
        
        
        if let imageURL = tweet.user?.profileUrl {
            
            profilepix.setImageWith(imageURL)
            
        }
        
        

        // Do any additional setup after loading the view.
    }

      
    var retweeted = false
    var favorite = false
    
    @IBAction func onReTweet(_ sender: Any) {
        if retweeted == false {
            retweetButton.setImage(UIImage (named: "retweet_icon_blue"), for: UIControlState.normal)
            retweetCount.text = "\(Int(retweetCount.text!)! + 1)"
            retweeted = true
        } else {
            retweetButton.setImage(UIImage(named: "retweet_icon"), for: UIControlState.normal)
            retweetCount.text = "\(Int(retweetCount.text!)! - 1)"
            retweeted = false
        
        }
    }
    
    
    
    @IBAction func onLike(_ sender: Any) {
        if favorite == false{
            likeButton.setImage(UIImage (named: "like_icon_blue"), for: UIControlState.normal)
            likeCount.text = "\(Int(likeCount.text!)! + 1)"
            favorite = true
        } else {
            likeButton.setImage(UIImage (named: "like_icon"), for: UIControlState.normal)
            likeCount.text = "\(Int(likeCount.text!)! - 1)"
            favorite = false
        
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
