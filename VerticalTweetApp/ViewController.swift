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

    /*キーボード閉じる処理*/
    func textFieldShouldEndEditing(_ tweetBOX: UITextField) -> Bool{
        
        tweetText = tweetBOX.text!
        
        // キーボードを閉じる
        tweetBOX.resignFirstResponder()
        
        print(tweetText)
        return true
    }
    
    /*分割処理*/
    func Split() {
        tweetText = ""//変数初期化
        let text = tweetBOX!.text
        let characters = text!.characters.map { String($0) }//一文字ごとにsplit
        print(characters)//debug
        
        var newText = characters.map {tweetText=tweetText+$0 + "\n"}//縦分割&mapを全部くっつける
        
        print(newText)//debug
        
    }
    
    /*tweet*/
    func tweet()  {
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            // make controller to share on twitter
            let slc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            slc?.setInitialText(tweetText+"#タテッター")
            
            // ツイート入力画面表示
            present(slc!, animated: true, completion: {
            })
            
            
            slc?.completionHandler = {
                (result:SLComposeViewControllerResult) -> () in
                switch (result) {
                    
                // tweet
                case SLComposeViewControllerResult.done:
                    print("tweeted")
                    
                // キャンセル
                case SLComposeViewControllerResult.cancelled:
                    print("cancel")
                    
                }
            }
        } else {
            print("not tweet")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

