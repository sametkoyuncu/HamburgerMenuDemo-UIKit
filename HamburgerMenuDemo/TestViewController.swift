//
//  TestViewController.swift
//  HamburgerMenuDemo
//
//  Created by Samet Koyuncu on 10.11.2022.
//

import UIKit

class TestViewController: UIViewController {
    
    var menuView: MenuView?

    override func viewDidLoad() {
        super.viewDidLoad()
        menuView = MenuView(frame: CGRect(x: -285, y: 0, width: 280, height: view.frame.height), vc: self)
    }
    
    @IBAction func asd(_ sender: Any) {
        print("asdd")
        menuView?.toggleMenu()
    }
  

}
