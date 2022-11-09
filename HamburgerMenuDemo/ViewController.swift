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
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        hamburgerMenuView.toggleMenu()
    }
}
