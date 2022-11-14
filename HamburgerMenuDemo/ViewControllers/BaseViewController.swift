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
        let config: MenuConfig = .init(vc: self, customView: menuView, position: .left)
        sideMenu = SideMenu(config)
        
        // left edge swipe action
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = sideMenu.getPosition() == .left ? .left : .right
        
        view.addGestureRecognizer(edgePan)
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
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            sideMenu.openMenu()
        }
    }
}
