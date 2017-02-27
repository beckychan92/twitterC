//
//  TweetsViewController.swift
//  twitterC
//
//  Created by Becky Chan on 2/26/17.
//  Copyright © 2017 Becky Chan. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    //, UITableViewDelegate, UITableViewDataSource
    
    var tweets: [Tweet] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            for tweet in tweets {
                print(tweet.text!)
            }
            self.tableView.reloadData()
        }, failure: { (error) in
            print(error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tweets.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet", for: indexPath) as! Tweet
//        if tweets != nil {
//            cell.tweet = tweets?[indexPath.row]
//            cell.selectionStyle = .none
//        
//        }
//        return cell
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
