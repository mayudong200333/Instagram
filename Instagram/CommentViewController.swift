//
//  CommentViewController.swift
//  Instagram
//
//  Created by 馬煜東 on 2019/11/07.
//  Copyright © 2019年 ikutou.ba. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    @IBOutlet weak var commentField: UITextField!
    var postData:PostData?
    
    @IBAction func handleCommentButoon(_ sender: Any) {
        if commentField.text==nil{
            SVProgressHUD.showError(withStatus: "コメントを入力してください")
            return
        }
        let postRef=Database.database().reference().child(Const.Postpath).child((postData?.id!)!)
        let comment=["comment":commentField.text!]
        postRef.updateChildValues(comment)
        print("コメント更新しました!")
        self.view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
}
