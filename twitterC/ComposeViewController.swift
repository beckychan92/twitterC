//
//  ComposeViewController.swift
//  twitterC
//
//  Created by Becky Chan on 3/4/17.
//  Copyright © 2017 Becky Chan. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var profilePhoto: UIImageView! //
    @IBOutlet weak var userName: UILabel! //
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var tweet: Tweet?
    var user: User!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = user?.screenname
        profilePhoto.setImageWith((user?.profileUrl)! as URL)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func oncancelButton(_ sender: Any) {
        print("cancel func works!")
        performSegue(withIdentifier: "TweetsViewController", sender: self)
        
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
