//
//  PostTableCellTableViewCell.swift
//  Instagram
//
//  Created by 馬煜東 on 2019/11/06.
//  Copyright © 2019年 ikutou.ba. All rights reserved.
//

import UIKit
import Firebase

class PostTableCellTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentField: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPostData(_ postData:PostData){
        self.postImageView.image=postData.image
        
        self.captionLabel.text="\(postData.name!):\(postData.caption!)"
        let likeNumber=postData.likes.count
        likeLabel.text="\(likeNumber)"
        
        let formatter=DateFormatter()
        formatter.dateFormat="yyyy-MM-dd HH:MM"
        let dateString=formatter.string(from: postData.date!)
        self.dateLabel.text=dateString
        
        if postData.isLiked{
            let buttonImage=UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else{
            let buttonImage=UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        if postData.comments.count == 0{
            commentField.text=""
        }else{
            commentField.text=""
            for comment in postData.comments{
                commentField.text! += "\(comment)\n"
            }
        }
        
    }
    
}
