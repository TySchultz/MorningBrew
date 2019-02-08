//
//  HTMLCell.swift
//  MorningBrew
//
//  Created by Ty Schultz on 12/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import HTMLString
import WebKit
class HTMLCell: UIView {

    static let height :CGFloat = 425
    
    static func cellHeight(width: CGFloat) -> CGFloat {
        return HTMLCell.height
    }
    
    var webView : WKWebView = WKWebView()
    
    init(article: Article, width: CGFloat) {
        let height = HTMLCell.cellHeight(width: width)
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        self.snp.makeConstraints { (make) in
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        let config = WKWebViewConfiguration.init()
        config.ignoresViewportScaleLimits = false
        webView = WKWebView(frame: self.bounds, configuration: config)
        webView.scrollView.isScrollEnabled = false
        self.addSubview(webView)
        self.addCSS()
        webView.loadHTMLString(article.html, baseURL: nil)
    }
    
    func addCSS() {
        guard let path = Bundle.main.path(forResource: "style", ofType: "css") else { return }
        let style = try! String(contentsOfFile: path).trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard let pathTwo = Bundle.main.path(forResource: "fonts", ofType: "css") else { return }
        let fonts = try! String(contentsOfFile: path).trimmingCharacters(in: .whitespacesAndNewlines)

        guard let pathThree = Bundle.main.path(forResource: "custom", ofType: "css") else { return }
        let custom = try! String(contentsOfFile: path).trimmingCharacters(in: .whitespacesAndNewlines)

        let jsStringOne = "var style = document.createElement('custom'); style.innerHTML = '\(custom)'; document.head.appendChild(style);"
        let jsStringTwo = "var style = document.createElement('style'); style.innerHTML = '\(style)'; document.head.appendChild(style);"
        let jsStringThree = "var style = document.createElement('fonts'); style.innerHTML = '\(fonts)'; document.head.appendChild(style);"

        webView.evaluateJavaScript(jsStringOne, completionHandler: nil)
        webView.evaluateJavaScript(jsStringTwo, completionHandler: nil)
        webView.evaluateJavaScript(jsStringThree, completionHandler: nil)

//        webView.evaluateJavaScript(jsStringThree, completionHandler: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
