//
//  DataService.swift
//  Social-With-Me
//
//  Created by Vincent Chau on 1/10/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let ds = DataService()
    private var _REF_BASE = Firebase(url:  "https://share-with-me-1018.firebaseio.com/")
    var REF_BASE: Firebase {
        return _REF_BASE
    }
}