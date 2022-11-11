//
//  BaseViewController.swift
//  HamburgerMenuDemo
//
//  Created by fmss on 11.11.2022.
//

import UIKit

class BaseViewController: UIViewController {
    private var menuView: MenuView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView = MenuView(vc: self)
    }
    
    func toggleMenu() {
        menuView.toggleMenu()
    }
    
    func openMenu() {
        menuView.openMenu()
    }
    
    func closeMenu() {
        menuView.closeMenu()
    }
}
