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
        let name=Auth.auth().currentUser?.displayName
        postData?.comments.append(String(name!)+":"+commentField.text!)
        let comment=["comments":postData?.comments]
        postRef.updateChildValues(comment as [AnyHashable : Any])
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
