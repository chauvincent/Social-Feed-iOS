//
//  FeedViewController.swift
//  Social-With-Me
//
//  Created by Vincent Chau on 1/10/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

import UIKit
import Firebase
class FeedViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!
    
    var posts = [Post]()
 
    
    static var imgCache = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(-20.0, 0.0, 0.0, 0.0);
        
        // called when data changed, return array of posts
        DataService.ds.REF_POSTS.observeEventType(.Value, withBlock: {snapshot in
                print(snapshot.value)
            
            self.posts = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots{
                    print("Snap: \(snap)")
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject>{
                        let key = snap.key //grab post key id
                        let post = Post.init(postKey: key, dict: postDictionary)
                        self.posts.append(post)
                    }
                }
            }
            
            self.tableView.reloadData()
        })

    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
       // print(post.postDescription)
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostTableViewCell") as? PostTableViewCell{
            
            // cancel request optional if same cell
            cell.request?.cancel()
            
            var img: UIImage?
            
            if let url = post.imageUrl{
                img = FeedViewController.imgCache.objectForKey(url) as? UIImage
            }
            
            cell.configureCell(post, img: img)
            
            return cell
        }else{
            return PostTableViewCell()
        }
        
    }


}
