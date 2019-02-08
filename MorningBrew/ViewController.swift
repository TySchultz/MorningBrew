//
//  ViewController.swift
//  MorningBrew
//
//  Created by Ty Schultz on 12/8/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import AloeStackView
import SnapKit
import SafariServices
import WebKit
protocol ViewControllerDelegate {
    func didMoveToArticle(detailController: DetailController, article: Article)
}

class ViewController: MBStackViewController, ImageStoreListener, ViewControllerDelegate, MarkdownViewDelegate {
 
    func onTouchLink(url: URL) {
        if url.scheme == "file" {
            return
        } else if url.scheme == "https" {
            let safari = SFSafariViewController(url: url)
            self.present(safari, animated: true, completion: nil)
        }
    }
    
    var articles: [Article] = []
    var imageStore : ImageStore?

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageStore = ImageStore(delegate: self)
        
        let downloader = Downloader()
        downloader.downloadLatest { (articles) in
            print(articles)
            self.articles = articles.sorted(by: { (left, right) -> Bool in
                return left.order < right.order
            })
            self.addRows()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    public override func viewDidAppear(_ animated: Bool) {
//        self.addRows()
    }

    func addRows() {
        let bounds = self.view.bounds
        
        //header
        let headerImage = HeaderImageCell(image: nil, width: bounds.width)
        self.stackView.addRow(headerImage)
        self.stackView.hideSeparator(forRow: headerImage)

        //Markets
        
        for (index,article) in self.articles.enumerated() {
            let post = PostCell(postCategory: article.category,
                                           postTitle: article.title,
                                           width: bounds.width)
            stackView.addRow(post)
            stackView.setTapHandler(forRow: post) { [weak self] _ in
                guard let self = self else { return }
                self.viewWasTapped(article: article)
            }
        }
    }
    
    private func addSponsoredCells(article: Article) {
        let bounds = self.view.bounds

        let post = PostCell(postCategory: article.category,
                            postTitle: article.title,
                            width: bounds.width)
        stackView.addRow(post)
        stackView.setTapHandler(forRow: post) { [weak self] _ in
            guard let self = self else { return }
            self.viewWasTapped(article: article)
        }
        let markdownView = MarkdownCell(delegate: self, markdown: article.text, width: bounds.width)
        stackView.addRow(markdownView)
        return
    }
    
    private func addBreakroomCells(article: Article){
        let bounds = self.view.bounds
        
        let post = PostCell(postCategory: article.category,
                            postTitle: "",
                            width: bounds.width)
        stackView.addRow(post)
        stackView.setTapHandler(forRow: post) { [weak self] _ in
            guard let self = self else { return }
            self.viewWasTapped(article: article)
        }
        stackView.hideSeparator(forRow: post)
        
        let markdownView = MarkdownCell(delegate: self, markdown: article.text, width: bounds.width)
        stackView.addRow(markdownView)
    }

    private func viewWasTapped(article: Article ) {
        guard let imageStore = self.imageStore else {
            return
        }
        let modal = MainPageViewController()
//        modal.htmlSnippet = article.html
//        modal.configure(delegate: self, imageStore: imageStore, article: article, articles: self.articles)
        modal.view.backgroundColor = UIColor.white
//        modal.modalPresentationCapturesStatusBarAppearance = true

//        let transitionDelegate = SPStorkTransitioningDelegate()
//        transitionDelegate.isSwipeToDismissEnabled = false
//        transitionDelegate.showIndicator           = false
//        modal.transitioningDelegate                = transitionDelegate
//        modal.modalPresentationStyle               = .custom
        self.navigationController?.pushViewController(modal, animated: true)
//        self.present(modal, animated: true, completion: nil)
    }
    
    func didUpdateStore(url: String, image: UIImage) {
        
    }
    
    func didMoveToArticle(detailController: DetailController, article: Article) {
        detailController.dismiss(animated: true) {
            self.viewWasTapped(article: article)
        }
    }
    
}
