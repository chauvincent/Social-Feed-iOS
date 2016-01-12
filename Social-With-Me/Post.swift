//
//  Post.swift
//  Social-With-Me
//
//  Created by Vincent Chau on 1/12/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

import Foundation

class Post {
    private var _postDescription: String!
    private var _imageUrl: String?
    private var _username: String!
    private var _likes: Int!
    private var _postKey: String!
    // required
    var postDescription: String{
        return _postDescription
    }
    // optional
    var imageUrl: String?{
        return _imageUrl
    }
    var likes: Int{
        return _likes
    }
    var username: String{
        return _username
    }
    
    init(description: String, imageUrl: String?, username: String){
        self._postDescription = description
        self._imageUrl = imageUrl
        self._username = username
    }
    init(postKey: String, dict:Dictionary<String, AnyObject>){
        self._postKey = postKey
        
        if let likes = dict["likes"] as? Int {
            self._likes = likes
        }
        if let imgUrl = dict["imageUrl"] as? String{
            self._imageUrl = imgUrl
        }
        if let descript = dict["description"] as? String{
            self._postDescription = descript
        }
        
    }
}