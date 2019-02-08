//
//  DetailWebViewController.swift
//  MorningBrew
//
//  Created by Ty Schultz on 1/30/19.
//  Copyright © 2019 Ty Schultz. All rights reserved.
//

import UIKit
import WebKit
class DetailWebViewController: UIViewController {

    let webView = WKWebView()
    
    var htmlSnippet: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.frame = view.frame
        self.view.addSubview(webView)
        
        let url = Bundle.main.path(forResource: "testBrew", ofType: "html")!
       

        if let html = self.htmlSnippet,
             let baseHTML = try? String(contentsOfFile: url, encoding: String.Encoding.utf8){
            let fullHTML = baseHTML.replacingOccurrences(of: "___REPLACE___", with: html)
            self.webView.loadHTMLString(fullHTML, baseURL: nil)
        }
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
