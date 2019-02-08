//
//  PostCell.swift
//  MorningBrew
//
//  Created by Ty Schultz on 12/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import SnapKit
import StyledTextKit
class PostCell: UIView {

    static let titleInset = UIEdgeInsets(
        top: Styles.Sizes.rowSpacing,
        left: Styles.Sizes.columnSpacing,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.columnSpacing
    )
    
    static let height :CGFloat = 40
    
    static func cellHeight(postTitle: String, width: CGFloat) -> CGFloat {
        
        let style = Styles.Text.mainFeedTitle.with(foreground: Styles.Colors.Gray.dark.color)
        
        let builder = StyledTextBuilder(styledText: StyledText(
            style: style
        ))
        
        builder.add(text: postTitle, traits: .traitBold)
        
        let titleRendered = StyledTextRenderer(
            string: builder.build(),
            contentSizeCategory: .preferred,
            inset: PostCell.titleInset
        )
        
        let height = titleRendered.viewSize(in: width - 30).height
        return height + PostCell.height
    }
    
    
    private let categoryLabel = UILabel()
    
    private var titleRendered: StyledTextRenderer!
    private let postTitleView: StyledTextView = StyledTextView()


    
    init(postCategory: String, postTitle: String, width: CGFloat) {
        let height = PostCell.cellHeight(postTitle: postTitle, width: width)
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        configureTextView(postTitle: postTitle)
        self.addUI(postCategory: postCategory, width: width)
        self.configureUI(category: postCategory, width: width)
        
        self.snp.makeConstraints { (make) in
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTextView(postTitle: String) {
        let style = Styles.Text.mainFeedTitle.with(foreground: Styles.Colors.Gray.dark.color)
        
        let builder = StyledTextBuilder(styledText: StyledText(
            style: style
        ))
        
        builder.add(text: postTitle, traits: .traitBold)
        
        titleRendered = StyledTextRenderer(
            string: builder.build(),
            contentSizeCategory: .preferred,
            inset: PostCell.titleInset
        )
        
    }
    
    func addUI(postCategory: String, width: CGFloat) {
        self.addSubview(self.categoryLabel)
        self.categoryLabel.font = Styles.Text.secondaryBold.preferredFont
        if postCategory == "Sponsored" {
            self.categoryLabel.backgroundColor = Styles.Colors.Blue.medium.color
        }else {
            self.categoryLabel.backgroundColor = Styles.Colors.Yellow.medium.color
        }
        self.categoryLabel.textColor = UIColor.white
        self.categoryLabel.textAlignment = .center
        self.categoryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(8)
            make.top.equalTo(8)
            make.height.equalTo(24)
        }
    
        self.addSubview(self.postTitleView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let bounds = self.bounds
        self.postTitleView.reposition(for: bounds.width)
        let textViewFrame = self.postTitleView.frame
        self.postTitleView.frame = CGRect(
            origin: CGPoint(x:  textViewFrame.minX, y: textViewFrame.minY + PostCell.height),
            size: textViewFrame.size
        )
        
        self.postTitleView.isUserInteractionEnabled = false
        
        let categoryWidth = self.categoryLabel.frame.width
        self.categoryLabel.snp.makeConstraints { (make) in
            make.width.equalTo(categoryWidth + 16)
        }
    }
    
    private func configureUI(category : String, width: CGFloat) {
        self.categoryLabel.text = category.uppercased()
        self.postTitleView.configure(with: self.titleRendered, width: width)
        
        if category == "SPONSORED" {
            self.categoryLabel.backgroundColor = UIColor.blue
        }
    }
}
