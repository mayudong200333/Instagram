//
//  ViewController.swift
//  Instagram
//
//  Created by 馬煜東 on 2019/10/30.
//  Copyright © 2019年 ikutou.ba. All rights reserved.
//

import UIKit
import ESTabBarController
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        setupTab()
    }
    func setupTab(){
        let tabBarController:ESTabBarController=ESTabBarController(tabIconNames: ["home","camera","setting"])
        tabBarController.selectedColor=UIColor(red: 1.0, green: 0.44, blue: 0.11, alpha: 1)
        tabBarController.buttonsBackgroundColor=UIColor(red: 0.96, green: 0.91, blue: 0.87, alpha: 1)
        tabBarController.selectionIndicatorHeight=3
        
        addChild(tabBarController)
        let tabBarView=tabBarController.view!
        tabBarView.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(tabBarView)
        let safeArea=view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tabBarView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tabBarView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        tabBarController.didMove(toParent: self)
        
        let homeViewController=storyboard?.instantiateViewController(withIdentifier: "Home")
        let settingViewController=storyboard?.instantiateViewController(withIdentifier: "Setting")
        tabBarController.setView(homeViewController, at: 0)
        tabBarController.setView(settingViewController, at: 2)
        
        tabBarController.highlightButton(at: 1)
        tabBarController.setAction({
            let imageViewController=self.storyboard?.instantiateViewController(withIdentifier: "ImageSelect")
            self.present(imageViewController!, animated: true, completion: nil)
        }, at: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser==nil{
            let loginViewController=self.storyboard?.instantiateViewController(withIdentifier: "Login")
            self.present(loginViewController!, animated: true, completion: nil)
        }
        
    }
    

}
