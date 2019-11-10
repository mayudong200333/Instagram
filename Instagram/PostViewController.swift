//
//  PostViewController.swift
//  Instagram
//
//  Created by 馬煜東 on 2019/10/30.
//  Copyright © 2019年 ikutou.ba. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class PostViewController: UIViewController {
    
    var image:UIImage!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func handlePostButton(_ sender: Any) {
        let imageData=imageView.image!.jpegData(compressionQuality: 0.5)
        let imageString=imageData!.base64EncodedString(options: .lineLength64Characters)
        
        let time=Date.timeIntervalSinceReferenceDate
        let name=Auth.auth().currentUser?.displayName
        let postRef=Database.database().reference().child(Const.Postpath)
        let postdic=["caption":textField.text!,"image":imageString,"time":String(time),"name":name!]
        postRef.childByAutoId().setValue(postdic)
        
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func handleCancleButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image=image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
