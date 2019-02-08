//
//  MainPageViewController.swift
//  MorningBrew
//
//  Created by Ty Schultz on 1/30/19.
//  Copyright © 2019 Ty Schultz. All rights reserved.
//

import UIKit

class MainPageViewController: UIPageViewController {
    
    fileprivate var articles: [Article] = []
    
    fileprivate var pages: [UIViewController] = [UIViewController()]
    
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate   = self
        

        if let firstVC = pages.first
        {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        let downloader = Downloader()
        downloader.downloadLatest { (articles) in
            self.articles = articles.sorted(by: { (left, right) -> Bool in
                return left.order < right.order
            })
            self.pages.removeFirst()
            for article in self.articles {
                let detailWeb = DetailWebViewController()
                detailWeb.htmlSnippet = article.html
                self.pages.append(detailWeb)
            }
            self.setViewControllers([self.pages.first!], direction: .forward, animated: true, completion: nil)
        }
        
        let viewShadow = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        viewShadow.backgroundColor = UIColor.white
        viewShadow.layer.cornerRadius = 4.0
        viewShadow.layer.shadowColor = UIColor.black.cgColor
        viewShadow.layer.shadowOpacity = 0.6
        viewShadow.layer.shadowOffset = CGSize.zero
        viewShadow.layer.shadowRadius = 5
        self.view.addSubview(viewShadow)
        
        viewShadow.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(16.0)
            make.right.equalTo(self.view.snp.right).offset(-16.0)
            make.bottom.equalTo(self.view.snp.bottomMargin).offset(-16.0)
            make.height.equalTo(60)
        }
    }
}

extension MainPageViewController: UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0          else { return pages.last }
        
        guard pages.count > previousIndex else { return nil        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < pages.count else { return pages.first }
        
        guard pages.count > nextIndex else { return nil         }
        
        return pages[nextIndex]
    }
}

extension MainPageViewController: UIPageViewControllerDelegate { }

