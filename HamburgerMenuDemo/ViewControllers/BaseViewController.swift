//
//  BaseViewController.swift
//  HamburgerMenuDemo
//
//  Created by fmss on 11.11.2022.
//

import UIKit

class BaseViewController: UIViewController {
    private var sideMenu: SideMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // menu view inside side menu
        let menuView = MenuView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: 280,
                                              height: UIScreen.main.bounds.height),
                                vc: self) {
            self.sideMenu.closeMenu()
        }
        // side menu
        let config: MenuConfig = .init(vc: self, customView: menuView)
        sideMenu = SideMenu(config)
    }
    
    func openMenu() {
        sideMenu.openMenu()
    }
    
    func closeMenu() {
        sideMenu.closeMenu()
    }
    
    func toggleMenu() {
        sideMenu.toggleMenu()
    }
}
