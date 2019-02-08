//
//  MarkdownCell.swift
//  MorningBrew
//
//  Created by Ty Schultz on 12/16/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import MarkdownView
import SafariServices

protocol MarkdownViewDelegate {
    func onTouchLink(url: URL)
}
class MarkdownCell: UIView {

    let md = MarkdownView()
    var delegate : MarkdownViewDelegate?
    private let imageView = UIImageView()
    
    init(delegate: MarkdownViewDelegate, markdown: String, width: CGFloat) {
        
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: 0))

        
        var resourceFileDictionary: NSDictionary?
    
        self.delegate = delegate
        md.load(markdown: markdown)
        md.isScrollEnabled = false
        
        // called when rendering finished
        md.onRendered = { [weak self] height in
            guard let self = self else { return }
            self.snp.makeConstraints({ (make) in
                make.height.equalTo(height)
            })
        }
        
        md.onTouchLink = { [weak self] request in
            guard let url = request.url,
                let self = self,
                let delegate = self.delegate
                else { return false }

            delegate.onTouchLink(url: url)
            return false
        }
        
        self.addSubview(md)
        
        md.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addUI(image: UIImage?) {
    }
}
