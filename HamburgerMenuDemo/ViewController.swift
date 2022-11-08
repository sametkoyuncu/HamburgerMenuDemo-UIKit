//
//  ViewController.swift
//  HamburgerMenuDemo
//
//  Created by Samet Koyuncu on 7.11.2022.
//

import UIKit

enum MenuState {
    case open
    case close
}

class ViewController: UIViewController {

    @IBOutlet weak var hamburgerMenuView: MenuView!
    
    private let menuView = MenuView()
    
    
    var menuState: MenuState = .open
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //menuView.delegate = self
        
        hamburgerMenuView.delegate = self
    }

    @IBAction func buttonTapped(_ sender: Any) {
        print("button tapped")
        switch menuState {
        case .open:
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) { [weak self] in
                self?.hamburgerMenuView.frame.origin.x = -240
            }
            menuState = .close
        case .close:
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) { [weak self] in
                self?.hamburgerMenuView.frame.origin.x = -0
            }
            menuState = .open
        }

    }
    
}

extension ViewController: MenuViewDelegate {
    func didCloseButtonTapped() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut) { [weak self] in
            self?.hamburgerMenuView.frame.origin.x = -280
        }
        menuState = .close
    }
}
