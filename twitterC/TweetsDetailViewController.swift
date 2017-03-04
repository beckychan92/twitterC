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
    
    var tweet: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Tweet"
        //profile pix
        tweetLabel.text = tweet.description
        
        
        //username tweet

        
        //timestamp
//        timeStamp.text = Twe
        
        
        

        // Do any additional setup after loading the view.
    }

    
    @IBAction func onReTweet(_ sender: Any) {
    }
    
    @IBAction func onLike(_ sender: Any) {
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
