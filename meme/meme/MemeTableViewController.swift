//
//  MemeTableViewController.swift
//  meme
//
//  Created by Yeh-chi Lai on 2/1/16.
//  Copyright © 2016 iamhomebody. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController{
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableCell")!
        let meme = memes[indexPath.row]
        
        cell.imageView?.image = meme.finalImage
        
        return cell
    }
override     
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    @IBAction func addNewMeme(sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
}
