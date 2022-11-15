//
//  BaseViewController.swift
//  HamburgerMenuDemo
//
//  Created by fmss on 11.11.2022.
//

import UIKit
import SideTown

class BaseViewController: UIViewController {
    private var sideMenu: SideMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // menu view inside side menu
        let menuView = MenuView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: 280,
                                              height: UIScreen.main.bounds.height),
                                vc: self) { [weak self] in
            self?.sideMenu.closeMenu()
        }
        

                        
        // side menu
        let config: MenuConfig = .init(vc: self, customView: menuView, position: .left)
        sideMenu = SideMenu(config)
        
        configureNavbar()
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
    
    // MARK: - navbar config | navbar background color etc.
    func configureNavbar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
   
}
