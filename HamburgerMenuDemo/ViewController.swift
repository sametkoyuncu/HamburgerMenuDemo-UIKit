//
//  ViewController.swift
//  HamburgerMenuDemo
//
//  Created by Samet Koyuncu on 7.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var hamburgerMenuView: MenuView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hamburgerMenuView.delegate = self
        
        // MARK: - gesture
        let swipeGestureRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft(_:)))
        swipeGestureRecognizerLeft.direction = .left
        
        view.addGestureRecognizer(swipeGestureRecognizerLeft)
        
        let swipeGestureRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeRight(_:)))
        swipeGestureRecognizerRight.direction = .right
        
        view.addGestureRecognizer(swipeGestureRecognizerRight)
        
        // MARK: - navbar
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
    
    @objc private func didSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        hamburgerMenuView.swipeLeft()
    }
    
    @objc private func didSwipeRight(_ sender: UISwipeGestureRecognizer) {
        hamburgerMenuView.swipeRight()
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        hamburgerMenuView.toggleMenu()
    }
}
