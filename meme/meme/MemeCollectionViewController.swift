//
//  MemeCollectionViewController.swift
//  meme
//
//  Created by Yeh-chi Lai on 2/1/16.
//  Copyright © 2016 iamhomebody. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCell", forIndexPath: indexPath) as! MemeCollectionCell
        
        let meme = memes[indexPath.row]
        
        cell.topLabel.text = meme.topString
        cell.bottomLabel.text = meme.bottomString
        cell.imageView.image = meme.finalImage
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        <#code#>
    }
}