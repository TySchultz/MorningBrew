//
//  IconCell.swift
//  MorningBrew
//
//  Created by Ty Schultz on 12/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import SnapKit
class IconCell: UIView {

    
    private let CELLHEIGHT : CGFloat = 50.0
    
    private let imageView = UIImageView()
    private let label     = UILabel()

    init(image: UIImage?, labelText: String, width: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: CELLHEIGHT))
        self.addUI(image: image)
        
        self.label.text = labelText
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addUI(image: UIImage?) {
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(8)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(32)
            make.width.equalTo(32)
        }
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.image = image ?? UIImage(named: "testImage")!
        
        self.snp.makeConstraints { (make) in
            make.height.equalTo(CELLHEIGHT)
        }
        
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(8)
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(-8)
        }
    }
    
}
