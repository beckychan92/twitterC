//
//  ProfileViewController.swift
//  twitterC
//
//  Created by Becky Chan on 3/4/17.
//  Copyright © 2017 Becky Chan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var FollowingLabel: UILabel!
    @IBOutlet weak var FollowingCount: UILabel!
    
    @IBOutlet weak var FollowerLabel: UILabel!
    @IBOutlet weak var FollowersCount: UILabel!
    
    
    @IBOutlet weak var actualname: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    var tweet: Tweet?
    var user: User!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        backgroundImage.setImageWith()
        if let tweet = tweet{
            user = tweet.user
        }
        
        if let imageURL = user.profileUrl {
            
            profileImage.setImageWith(imageURL)
            
        }
        
        if let actual = user.name{
            print("found name")
            actualname.text = "\(actual)"
        }
        if let username = user.screenname{
            print("found name")
            userName.text = "\(username)"
        }
        
        FollowersCount.text = user.getFollower()
        FollowingCount.text = user.getFollowing()
        tweetCount.text = user.getStatusCount()
        
        

        // Do any additional setup after loading the view.
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
