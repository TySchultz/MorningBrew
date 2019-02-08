//
//  MBStackViewController.swift
//  MorningBrew
//
//  Created by Ty Schultz on 12/16/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import AloeStackView
class MBStackViewController: AloeStackViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.stackView.delegate = self
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
