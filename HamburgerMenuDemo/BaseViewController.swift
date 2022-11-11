//
//  BaseViewController.swift
//  HamburgerMenuDemo
//
//  Created by fmss on 11.11.2022.
//

import UIKit

class BaseViewController: UIViewController {
    var menuView: MenuView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView = MenuView(vc: self)
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        menuView.toggleMenu()
    }
}
