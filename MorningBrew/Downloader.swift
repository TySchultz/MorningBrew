//
//  Downloader.swift
//  MorningBrew
//
//  Created by Ty Schultz on 12/29/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase
import Alamofire
import AlamofireImage
class Downloader: NSObject {

    
    func downloadLatest(completion: @escaping (_ articles: [Article])->()) {
        Database.database().reference().child("Articles").observeSingleEvent(of: .value) {
            (snapshot) in
            guard let value = snapshot.value as? NSDictionary else { return }
            do {
                var articles: [Article] = []
                for (_,val) in value as! [String:[String:Any]]{
                    let article = try FirebaseDecoder().decode(Article.self, from: val)
                    print(article)
                    articles.append(article)
                }
                completion(articles)
            } catch let error {
                print(error)
            }
        }
    }
    
    func downloadImage(url: String, imageCache: ImageStore, completion: @escaping (_ image: UIImage?)->())  {
        if let image = imageCache.cache[url] {
            print("have image already")
            completion(image)
        }else {
            Alamofire.request(url).responseImage { response in
                if let image = response.result.value {
                    completion(image)
                }else {
                    completion(nil)
                }
            }
        }
    }
}

struct Article: Codable, Equatable {
    //Main info
    let title : String
    let category : String
    let text : String
    let html : String
    let order : Int
}

