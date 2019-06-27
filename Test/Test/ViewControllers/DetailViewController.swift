//
//  DetailViewController.swift
//  Test
//
//  Created by RakeshPC on 25/06/19.
//  Copyright © 2019 RakeshPC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "UISearchResultsUpdating protocol to make the search working"
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        
        let navBackButton = UIButton(type: .system)
        navBackButton.setImage(UIImage(named: "backNav_icon"), for: .normal)
        navBackButton.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        navBackButton.tintColor = .blue
        navBackButton.addTarget(self, action: #selector(buttonBackAction(sender:)), for: .touchUpInside)
        let leftBarItem = UIBarButtonItem(customView: navBackButton)
        self.navigationItem.leftBarButtonItem = leftBarItem;

        
        let navLikeButton = UIButton(type: .system)
        navLikeButton.setImage(UIImage(named: "like_icon"), for: .normal)
        navLikeButton.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        navLikeButton.tintColor = .red
        navLikeButton.addTarget(self, action: #selector(buttonBackAction(sender:)), for: .touchUpInside)
        let rightBarItem = UIBarButtonItem(customView: navLikeButton)
        self.navigationItem.rightBarButtonItem = rightBarItem;
        
    }
    
    @objc func buttonBackAction(sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
