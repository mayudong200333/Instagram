//
//  LoginViewController.swift
//  Instagram
//
//  Created by 馬煜東 on 2019/10/30.
//  Copyright © 2019年 ikutou.ba. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    
    @IBAction func handleLoginButton(_ sender: Any) {
        if let address=mailAddressTextField.text,let password=passwordTextField.text{
            if address.isEmpty||password.isEmpty{
                SVProgressHUD.showError(withStatus: "必須項目を入力してください")
                return
            }
            SVProgressHUD.show()
            
            Auth.auth().signIn(withEmail: address, password: password){user,error in
                if let error=error{
                    print("DEBUG_PRINT:"+error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "サイン失敗しました")
                    return
                }
                print("DEBUG_PRINT:ログイン成功しました。")
                SVProgressHUD.dismiss()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    @IBAction func handleCreateAccountButton(_ sender: Any) {
        if let address=mailAddressTextField.text,let password=passwordTextField.text,let displayName=displayNameTextField.text{
            if address.isEmpty||password.isEmpty||displayName.isEmpty{
                print("DEBUG_PRINT:何かが空文字です。")
                SVProgressHUD.showError(withStatus: "必須項目を入力してください")
                return
            }
            
            SVProgressHUD.show()
            Auth.auth().createUser(withEmail: address, password: password){
                user,error in
                if let error=error{
                    print("DEBUG_PRINT:"+error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "ユーザー作成に失敗しました。")
                    return
                }
                print("DEBUG_PRINT:ユーザー作成に成功しました。")
                
                let user=Auth.auth().currentUser
                if let user=user{
                    let changeRequest=user.createProfileChangeRequest()
                    changeRequest.displayName=displayName
                    changeRequest.commitChanges{error in
                        if let error=error{
                            print("DEBUG_PRINT:"+error.localizedDescription)
                            SVProgressHUD.showError(withStatus: "表示名の設定に失敗しました。")
                            return
                        }
                        print("DEBUG_PRINT:[displayName=\(user.displayName!)]の設定に成功しました")
                        SVProgressHUD.dismiss()
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    
}
