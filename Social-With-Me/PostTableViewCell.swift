//
//  PostTableViewCell.swift
//  Social-With-Me
//
//  Created by Vincent Chau on 1/10/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

import UIKit
import Alamofire

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView : UIImageView!
    @IBOutlet weak var postedImage: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
    
    var post: Post!
    var request: Request?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    // after profile image has size
    override func drawRect(rect: CGRect) {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        postedImage.clipsToBounds = true
    }

    func configureCell(post: Post, img: UIImage?){
        self.post = post
        
        self.descriptionText.text = post.postDescription
        self.likesLabel.text = "\(post.likes)"
        
        // post has images
        if post.imageUrl != nil{
            
            if img != nil{
                self.postedImage.image = img
                
            }else{
                // request and validate it is image
                request = Alamofire.request(.GET, post.imageUrl!).validate(contentType: ["image/*"]).response(completionHandler: { reqest, response, data, error in
                    if error == nil{
                        let img = UIImage(data: data!)!
                        self.postedImage.image = img
                        FeedViewController.imgCache.setObject(img, forKey: self.post.imageUrl!)
                    }
                })
            }
        }else{
            self.postedImage.hidden = true
        }
        
    }

}
