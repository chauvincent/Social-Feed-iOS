//
//  PostTableViewCell.swift
//  Social-With-Me
//
//  Created by Vincent Chau on 1/10/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView : UIImageView!
    @IBOutlet weak var postedImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
      
        
        
    }
    // after profile image has size
    override func drawRect(rect: CGRect) {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        postedImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
