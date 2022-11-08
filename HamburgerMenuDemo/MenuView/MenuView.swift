//
//  MenuView.swift
//  HamburgerMenuDemo
//
//  Created by Samet Koyuncu on 7.11.2022.
//

import UIKit

enum MenuState {
    case open
    case close
}

@IBDesignable
class MenuView: UIView {
    
    @IBOutlet var view: UIView!
    var menuState: MenuState = .close
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    @IBAction func ad(_ sender: Any) {
        print("aasdd")
    }
  
    @IBAction func mBtn(_ sender: Any) {
        print("m")
        switch menuState {
        case .open:
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) { [weak self] in
                self?.view.frame.origin.x = -240
            }
            menuState = .close
        case .close:
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) { [weak self] in
                self?.view.frame.origin.x = -0
            }
            menuState = .open
        }

    }
    
}


// delegate?.didCloseButtonTapped()

private extension MenuView {
    func commonInit() {
        let bundle = Bundle(for: MenuView.self)
        
        if let viewToAdd = bundle.loadNibNamed("MenuView", owner: self, options: nil), let contentView = viewToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
}
