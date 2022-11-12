//
//  MenuView.swift
//  HamburgerMenuDemo
//
//  Created by Samet Koyuncu on 7.11.2022.
//
import UIKit

@IBDesignable
final class MenuView: UIView {
    @IBOutlet private weak var tableView: UITableView!
    weak var delegate: UIViewController?
    var toggleMenu: (()->())?
    private override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit(using: "MenuView")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit(using: "MenuView")
    }
    
    init(frame: CGRect, vc: UIViewController, action: @escaping (()->())) {
        super.init(frame: frame)
        self.commonInit(using: "MenuView")
        self.toggleMenu = action
        delegate = vc
    }
}

extension MenuView {
    @IBAction func closeButtonTapped(_ sender: Any) {
        //toggleMenu()
        toggleMenu?()
        print("tapped")
    }
}

private extension MenuView {
    func commonInit(using nibName: String) {
        // connect MenuView.xib file and MenuView.class file
        let bundle = Bundle(for: MenuView.self)
        
        if let viewToAdd = bundle.loadNibNamed(nibName, owner: self, options: nil), let contentView = viewToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "headerCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "rowCell")
    }
}
