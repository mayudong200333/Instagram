//
//  SettingViewController.swift
//  Instagram
//
//  Created by 馬煜東 on 2019/10/30.
//  Copyright © 2019年 ikutou.ba. All rights reserved.
//

import UIKit
import ESTabBarController
import Firebase
import SVProgressHUD

class SettingViewController: UIViewController {
    
    @IBOutlet weak var displayNameTextField: UITextField!
    
    @IBAction func handleChangeButton(_ sender: Any) {
        if let displayName=displayNameTextField.text{
            if displayName.isEmpty{
                SVProgressHUD.showError(withStatus: "表示名を入力してください")
                return
            }
            let user=Auth.auth().currentUser
            if let user=user{
                let changeRequest=user.createProfileChangeRequest()
                changeRequest.displayName=displayName
                changeRequest.commitChanges{error in
                    if let error=error{
                        SVProgressHUD.showError(withStatus: "表示名の変更に失敗しました")
                        print("DEBUG_PRINT:"+error.localizedDescription)
                        return
                    }
                    print("[DEBUG_PRINT:displayName=\(displayName)]の設定に成功しました")
                    
                    SVProgressHUD.showSuccess(withStatus: "表示名変更しました")
                }
            }
        }
        self.view.endEditing(true)
    }
    
    @IBAction func handleLogoutButton(_ sender: Any) {
        try!Auth.auth().signOut()
        let loginViewController=self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.present(loginViewController!, animated: true, completion: nil)
        
        let tabBarController=parent as! ESTabBarController
        tabBarController.setSelectedIndex(0, animated: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let user=Auth.auth().currentUser
        if let user=user{
            displayNameTextField.text=user.displayName
        }
    }
    
    
    
}
