//
//  TweetsViewController.swift
//  twitterC
//
//  Created by Becky Chan on 2/26/17.
//  Copyright © 2017 Becky Chan. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var tweets: [Tweet] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func logoutButton(_ sender: Any) {
        TwitterClient.sharedInstance!.logout()
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in twitter cntrl")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) in
            
            self.tweets = tweets
            print("success!")
           
            self.tableView.reloadData()
        }, failure: { (error) in
            print(error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("this is tweets")
        return self.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet", for: indexPath) as! TweetCell
        let tweet = self.tweets[indexPath.row]
        cell.tweet = tweet
        print("got cell")
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sender = sender as? TweetCell{
            print("segue called on TweetCell")

            let indexPath = tableView.indexPath(for: sender)
            let vc = segue.destination as! TweetsDetailViewController
            let cell = self.tableView(self.tableView, cellForRowAt: indexPath!) as! TweetCell
            vc.tweet = cell.tweet
        }else if let sender = sender as? UIBarButtonItem{
            if sender.image! == UIImage(named: "compose")!{
                let vc = segue.destination as! ComposeViewController
                vc.user = User.currentUser!
            } else {
                _ = segue.identifier as! TweetsViewController
            }
    
            
        } else {
            let vc = segue.destination as! ProfileViewController
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! TweetCell
            
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets[(indexPath?.row)!]
            vc.tweet = tweet
        }
 
    }
}
