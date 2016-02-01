//
//  ViewController.swift
//  meme
//
//  Created by Yeh-chi Lai on 1/5/16.
//  Copyright © 2016 iamhomebody. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var textFieldTop: UITextField!
    @IBOutlet weak var textFieldBottom: UITextField!
    var ifKeyboardShown:Bool = false
    var memes: [Meme]!
    
    let memeTextFieldDelegate = MemeTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        textFieldTop.textAlignment = NSTextAlignment.Center
        textFieldBottom.textAlignment = NSTextAlignment.Center
        textFieldTop.delegate = memeTextFieldDelegate
        textFieldBottom.delegate = memeTextFieldDelegate
        
        // get meme pictures
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        
        subscribeToKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }

    @IBAction func pickImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            mImage.image = image
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func pickCameraImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveMemedImage(sender: AnyObject) {
        save()
    }
    
    @IBAction func shareImage(sender: AnyObject) {
        
        let vc = UIActivityViewController(activityItems: ["Watch my Meme picture", generateMemedImage()], applicationActivities: nil)
        self.presentViewController(vc, animated: true, completion: nil)
        //self.presentViewController(vc, animated: true, completion: { self.save() })
    }
    
    // Keyboard: Show Keyboard
    func keyboardWillShow(notification: NSNotification){
        if ifKeyboardShown == false{
            view.frame.origin.y -= getKeyboardHeight(notification)
            ifKeyboardShown = true
        }
        
    }
    
    // Keyboard: Hide Keyboard
    func keyboardWillHide(notification: NSNotification){
        if ifKeyboardShown == true{
            view.frame.origin.y += getKeyboardHeight(notification)
            ifKeyboardShown = false
        }
        
    }
    
    func subscribeToKeyboardNotifications(){
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    
    
    // Generate a memed Image
    func generateMemedImage() -> UIImage
    {
        // TODO: Hide toolbar and navbar 
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO:  Show toolbar and navbar
        
        return memedImage
    }
    
    // Save a memed image
    func save(){
        let myMeme = Meme(text: textFieldTop.text!, image: mImage.image!, memedImage: generateMemedImage())
        
        // Add it to the memes array in the Application Delegate
        (UIApplication.sharedApplication().delegate as!
            AppDelegate).memes.append(myMeme)
    }
}

class Meme {
    var topString:String
    var bottomString:String
    var originImage:UIImage
    var finalImage:UIImage
    
    init(text: String, image:UIImage, memedImage: UIImage){
        self.topString = text
        self.bottomString = text
        self.originImage = image
        self.finalImage = memedImage
    }
    

}

