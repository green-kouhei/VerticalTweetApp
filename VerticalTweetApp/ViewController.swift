//
//  ViewController.swift
//  VerticalTweetApp
//
//  Created by しょうじこうへい on 2017/05/29.
//  Copyright © 2017年 KouheiShoji. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {
    
    var tweetText:String=""
    
    @IBAction func tweetButton(_ sender: Any) {
        Split()
        tweet()
    }
   
    @IBOutlet weak var tweetBOX: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetBOX!.delegate = self as? UITextFieldDelegate
        tweetBOX!.returnKeyType = .done
        
        
    }

    func textFieldShouldEndEditing(_ tweetBOX: UITextField) -> Bool{
        
        tweetText = tweetBOX.text!
//        print(tweetText)
        
        // キーボードを閉じる
        tweetBOX.resignFirstResponder()
        
        print(tweetText)
        return true
    }
    
    
    func Split() {
        tweetText = ""
        let text = tweetBOX!.text
        let characters = text!.characters.map { String($0) }
        print(characters)
        
        var newText = characters.map {tweetText=tweetText+$0 + "\n"}
//        tweetText = characters.map {$0 + "\n"}
        
        print(newText)
        
        
        
//        tweetText = newText as! String
        
        
//        tweetText=tweetText+text
    }
    
    func tweet()  {
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            // make controller to share on twitter
            let slc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            slc?.setInitialText(tweetText+"#タテッター")
//            slc?.setInitialText("#タテッター")
            
            // ツイート入力画面表示
            present(slc!, animated: true, completion: {
            })
            
            // 事後処理
            slc?.completionHandler = {
                (result:SLComposeViewControllerResult) -> () in
                switch (result) {
                    
                // 投稿
                case SLComposeViewControllerResult.done:
                    print("tweeted")
                    
                // キャンセル
                case SLComposeViewControllerResult.cancelled:
                    print("tweet cancel")
                    
                }
            }
        } else {
            print("can not tweet")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

