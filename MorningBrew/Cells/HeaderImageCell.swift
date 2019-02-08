//
//  HeaderImageCell.swift
//  MorningBrew
//
//  Created by Ty Schultz on 12/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import SnapKit
class HeaderImageCell: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private let CELLHEIGHT : CGFloat = 64.0
    
    private let imageView = UIImageView()
    private var image : UIImage? {
        didSet{
            guard let image = image else { return }
            self.imageView.image = image
        }
    }
    
    init(image: UIImage?, width: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: CELLHEIGHT))
        self.addUI()
        self.image = image
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addUI () {
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(-16)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        }
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "headerImage")!
        
        self.snp.makeConstraints { (make) in
            make.height.equalTo(CELLHEIGHT)
        }
    }


}
