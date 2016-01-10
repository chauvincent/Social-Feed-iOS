//
//  DataService.swift
//  Social-With-Me
//
//  Created by Vincent Chau on 1/10/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = "https://share-with-me-1018.firebaseio.com/"

class DataService {
    static let ds = DataService()
    private var _REF_BASE = Firebase(url:  "\(URL_BASE)")
    private var _REF_POSTS = Firebase(url: "\(URL_BASE)/posts")
    private var _REF_USERS = Firebase(url: "\(URL_BASE)/users")

    var REF_BASE: Firebase {
        return _REF_BASE
    }
    
    var REF_POSTS: Firebase{
        return _REF_POSTS
    }
    var REF_USERS: Firebase{
        return _REF_USERS
    }
    func createFirebaseUser(uid: String, user: Dictionary<String, String>){
        //get user id on the path, create user
        REF_USERS.childByAppendingPath(uid).setValue(user)
        
    }
}