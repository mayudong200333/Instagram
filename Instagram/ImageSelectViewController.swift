//
//  ImageSelectViewController.swift
//  Instagram
//
//  Created by 馬煜東 on 2019/10/30.
//  Copyright © 2019年 ikutou.ba. All rights reserved.
//

import UIKit
import CLImageEditor

class ImageSelectViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,CLImageEditorDelegate{

    @IBAction func handleLibraryButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let pickerController=UIImagePickerController()
            pickerController.delegate=self
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func handleCameraButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let pickerController=UIImagePickerController()
            pickerController.delegate=self
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[.originalImage] != nil{
            let image=info[.originalImage] as! UIImage
            
            let editor=CLImageEditor(image:image)!
            editor.delegate=self
            print("DEBUG_PRINT:image=\(image)")
            picker.pushViewController(editor, animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imageEditor(_ editor: CLImageEditor!, didFinishEditingWith image: UIImage!) {
        let postViewController=self.storyboard?.instantiateViewController(withIdentifier: "Post") as! PostViewController
        postViewController.image=image!
        editor.present(postViewController, animated: true, completion: nil)
    }


   

}
