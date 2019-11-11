//
//  HomeViewController.swift
//  Instagram
//
//  Created by 馬煜東 on 2019/10/30.
//  Copyright © 2019年 ikutou.ba. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var postArray:[PostData]=[]
    
    var observing=false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate=self
        tableView.dataSource=self
        
        tableView.allowsSelection=false
        
        let nib=UINib(nibName: "PostTableCellTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        tableView.rowHeight=UITableView.automaticDimension
        tableView.estimatedRowHeight = UIScreen.main.bounds.height+100
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG_PRINT:viewWillAppear")
        
        if Auth.auth().currentUser != nil{
            if self.observing==false{
                let postRef=Database.database().reference().child(Const.Postpath)
                postRef.observe(.childAdded, with: {snapshot in
                    print("DEBUG_PRINT: .childAddedイベントが発生しました。")
                    if let uid=Auth.auth().currentUser?.uid{
                        let postData=PostData(snapshot: snapshot, myId: uid)
                        self.postArray.insert(postData, at: 0)
                        
                        self.tableView.reloadData()
                    }
                })
                postRef.observe(.childChanged, with: {snapshot in
                    print("DEBUG_PRINT: .childChangedイベントが発生しました。")
                    if let uid=Auth.auth().currentUser?.uid{
                        let postData=PostData(snapshot: snapshot, myId: uid)
                        
                        var index:Int=0
                        for post in self.postArray{
                            if post.id==postData.id{
                                index=self.postArray.firstIndex(of: post)!
                                break
                            }
                        }
                        self.postArray.remove(at: index)
                        self.postArray.insert(postData, at: index)
                        self.tableView.reloadData()
                    }
                })
                observing=true
            }
        }else{
            if observing==true{
                postArray=[]
                tableView.reloadData()
                let postRef=Database.database().reference().child(Const.Postpath)
                postRef.removeAllObservers()
                observing=false
            }
        }
    }


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return postArray.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostTableCellTableViewCell
    cell.setPostData(postArray[indexPath.row])
    cell.likeButton.addTarget(self, action: #selector(handleButton(_:forEvent:)), for: .touchUpInside)
    cell.commentButton.addTarget(self, action: #selector(handleCommentButton(_:forEvent:)), for: .touchUpInside)
    return cell
}

    @objc func handleButton(_ sender:UIButton,forEvent event:UIEvent){
        print("DEBUG_PRINT:likeボタンタップされました")
        
        let touch=event.allTouches?.first
        let point=touch!.location(in: self.tableView)
        let indexPath=tableView.indexPathForRow(at: point)
        
        let postData=postArray[indexPath!.row]
        
        if let uid=Auth.auth().currentUser?.uid{
            if postData.isLiked{
                var index = -1
                for likeId in postData.likes{
                    if likeId==uid{
                        index=postData.likes.firstIndex(of: likeId)!
                        break
                    }
                }
                postData.likes.remove(at: index)
             
            }else{
                postData.likes.append(uid)
            }
            
            let postRef=Database.database().reference().child(Const.Postpath).child(postData.id!)
            let likes=["likes":postData.likes]
            postRef.updateChildValues(likes)
            
        }
    }
    
    @objc func handleCommentButton(_ sender:UIButton,forEvent event:UIEvent){
        print("DEBUG_PRINT:コメントボタンタップされました")
        
        let commentViewController=self.storyboard?.instantiateViewController(withIdentifier: "Comment")as!CommentViewController
        let touch=event.allTouches?.first
        let point=touch!.location(in: self.tableView)
        let indexPath=tableView.indexPathForRow(at: point)
        commentViewController.postData=postArray[indexPath!.row]
        self.present(commentViewController, animated: true, completion: nil)
    }

}
