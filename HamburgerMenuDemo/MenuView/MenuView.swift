//
//  MenuView.swift
//  HamburgerMenuDemo
//
//  Created by Samet Koyuncu on 7.11.2022.
//

import UIKit

protocol MenuViewDelegate: AnyObject {
    func didCloseButtonTapped()
}

@IBDesignable
class MenuView: UIView {
    
    var handleClick: (()->())?
    
    weak var delegate: MenuViewDelegate?
    
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
