//
//  BaseViewController.swift
//  HamburgerMenuDemo
//
//  Created by fmss on 11.11.2022.
//

import UIKit

class BaseViewController: UIViewController {
    private var sideMenu: SideMenu!
    
    // TODO: Your Menu View
//    let customView: UIView = {
//        let v = UIView(frame: CGRect(x: 0, y: 0, width: 280, height: UIScreen.main.bounds.height))
//        v.backgroundColor = .red
//        return v
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menuView = MenuView(frame: CGRect(x: 0, y: 0, width: 280, height: UIScreen.main.bounds.height), vc: self) {
            self.sideMenu.toggleMenu()
        }
        
        sideMenu = SideMenu(vc: self, customView: menuView, position: .left)
    }
    
    func toggleMenu() {
        sideMenu.toggleMenu()
    }
    
    func openMenu() {
        sideMenu.openMenu()
    }
    
    func closeMenu() {
        sideMenu.closeMenu()
    }
}
