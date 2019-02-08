//
//  ImageCell.swift
//  MorningBrew
//
//  Created by Ty Schultz on 12/16/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit

class ImageCell: UIView {
    
    
    private let imageView = UIImageView()
    
    init(image: UIImage?, width: CGFloat) {
        guard let image = image else {
            super.init(frame: CGRect.zero)
            return
        }
        
        let height = image.size.height
        let ratio = image.size.width / 375.0
        let cellHeight = height/ratio
        
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: cellHeight))
        self.snp.makeConstraints { (make) in
            make.height.equalTo(cellHeight)
        }
        self.addUI(image: image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addUI(image: UIImage?) {
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.top.equalTo(0)
        }
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.image = image ?? UIImage(named: "testImage")!
    }
}
