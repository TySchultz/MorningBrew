//
//  ImageCache.swift
//  Akta
//
//  Created by Ty Schultz on 10/21/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import Foundation

protocol ImageStoreListener: class {
    func didUpdateStore(url: String, image: UIImage)
}

class ListenerWrapper {
    weak var listener: ImageStoreListener?
    
    init(listener: ImageStoreListener) {
        self.listener = listener
    }
}

final class ImageStore: NSObject {
    //Main info
    var cache: [String: UIImage] = [:]
    var delegate: ImageStoreListener?

    
    init(delegate: ImageStoreListener?) {
        super.init()
        self.delegate = delegate
    }
}
