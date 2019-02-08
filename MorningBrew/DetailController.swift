//
//  DetailController.swift
//  MorningBrew
//
//  Created by Ty Schultz on 12/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//
import UIKit
import AloeStackView
import SnapKit
import SafariServices
class DetailController: MBStackViewController, MarkdownViewDelegate {
    
    func onTouchLink(url: URL) {
        if url.scheme == "file" {
            return
        } else if url.scheme == "https" {
            let safari = SFSafariViewController(url: url)
            self.present(safari, animated: true, completion: nil)
        }
    }
    
    private var article: Article?
    private var articles: [Article]?
    private var imageStore: ImageStore?
    private var delegate: ViewControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.updateCells()
//        self.stackView.frame = CGRect(x: 0, y: 10, width: self.view.bounds.width, height: self.view.bounds.height-10)
//        self.view.addSubview(stackView)
        // Do any additional setup after loading the view, typically from a nib.
       
    }
    
    public override func viewDidAppear(_ animated: Bool) {
       
    }
    
    public override func viewDidLayoutSubviews() {
        
    }
    
    func updateCells() {
        guard let article = self.article else {
            return
        }
        
        let width = self.view.frame.width
        
        let post = PostCell(postCategory: article.category,
                            postTitle: article.title,
                            width: width)
        stackView.addRow(post)
        
        let markdownView = MarkdownCell(delegate: self, markdown: article.text, width: width)
        stackView.addRow(markdownView)
        
        self.addPreviousNext()
    }
    
    func addPreviousNext() {
        guard let article = self.article,
            let articles = self.articles,
            let index = articles.firstIndex(of: article) else {
                return
        }
        let width = self.view.frame.width

        if index - 1 > 0 {
            let previousArticle = articles[index - 1]
            let postCell = PostCell(postCategory: previousArticle.category, postTitle: "PREVIOUS: " + previousArticle.title, width: width)
            self.stackView.addRow(postCell)
            self.stackView.setTapHandler(forRow: postCell) { [weak self] _ in
                guard let self = self else { return }
                self.viewWasTapped(article: previousArticle)
            }
        }
        
        if index + 1 < articles.count {
            let nextArticle = articles[index + 1]
            guard !nextArticle.category.contains("BREAKROOM") else {
                return
            }
            
            let postCell = PostCell(postCategory: nextArticle.category, postTitle: "NEXT: " + nextArticle.title, width: width)
            self.stackView.addRow(postCell)
            self.stackView.setTapHandler(forRow: postCell) { [weak self] _ in
                guard let self = self else { return }
                self.viewWasTapped(article: nextArticle)
            }
        }
    }
    
    private func viewWasTapped(article: Article ) {
        
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.didMoveToArticle(detailController: self, article: article)
    }
    
    
    func configure(delegate: ViewControllerDelegate,imageStore: ImageStore, article: Article, articles: [Article]) {
        self.delegate = delegate
        self.article = article
        self.imageStore = imageStore
        self.articles = articles
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        SPStorkController.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset = scrollView.contentOffset.y
        
        if offset < -110 {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
