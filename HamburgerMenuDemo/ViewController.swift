//
//  ViewController.swift
//  HamburgerMenuDemo
//
//  Created by Samet Koyuncu on 7.11.2022.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var hamburgerMenuView: MenuView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hamburgerMenuView.menuState = .closed
        hamburgerMenuView.delegate = self
        hamburgerMenuView.handleClick = { [weak self] in
            print("handleClick")
            self?.toggleMenu()
        }

    }
    @IBAction func button(_ sender: Any) {
        print("view")
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        toggleMenu()
    }
    
    func toggleMenu() {
        switch hamburgerMenuView.menuState {
        case .opened:
            UIView.animate(withDuration: 0.8,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) { [weak self] in
                self?.hamburgerMenuView.frame.origin.x = -285
                self?.menuButton.frame.origin.x = 0
                self?.menuButton.setImage(UIImage(named: "menu"), for: .normal)
            }
            hamburgerMenuView.menuState = .closed
        case .closed:
            UIView.animate(withDuration: 0.8,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) { [weak self] in
                self?.hamburgerMenuView.frame.origin.x = -5
                self?.menuButton.frame.origin.x = 210
                self?.menuButton.setImage(UIImage(named: "close"), for: .normal)
            }
            hamburgerMenuView.menuState = .opened
        default:
                break
        }
    
    }
}

extension ViewController: MenuViewDelegate {
    func didCloseButtonTap() {
        toggleMenu()
    }
    
    
}
