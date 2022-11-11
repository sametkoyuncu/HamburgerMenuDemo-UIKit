//
//  ViewController.swift
//  HamburgerMenuDemo
//
//  Created by Samet Koyuncu on 7.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var menuView: MenuView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView = MenuView(vc: self)
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        menuView.toggleMenu()
    }
}
