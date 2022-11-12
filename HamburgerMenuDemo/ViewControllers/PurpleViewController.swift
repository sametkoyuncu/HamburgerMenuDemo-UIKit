//
//  PurpleViewController.swift
//  HamburgerMenuDemo
//
//  Created by fmss on 11.11.2022.
//

import UIKit

class PurpleViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        super.toggleMenu()
    }
    @IBAction func pushTapped(_ sender: Any) {
        super.closeMenu()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RedVC") as! RedViewController
        
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
