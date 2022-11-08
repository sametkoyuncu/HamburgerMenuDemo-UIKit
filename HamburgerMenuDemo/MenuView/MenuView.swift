//
//  MenuView.swift
//  HamburgerMenuDemo
//
//  Created by Samet Koyuncu on 7.11.2022.
//

import UIKit

enum MenuState {
    case opened
    case closed
}

protocol MenuViewDelegate: AnyObject {
    func didCloseButtonTap()
}

@IBDesignable
class MenuView: UIView {
    @IBOutlet weak var tableView: UITableView!
    
    var menuState: MenuState?
    weak var delegate: MenuViewDelegate?
    
    var handleClick: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
 
    @IBAction func mBtn(_ sender: Any) {
        delegate?.didCloseButtonTap()
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
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}


// Mark: - TableView Delegate Methods
extension MenuView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
    }
}

// Mark: - TableView DataSource Methods
extension MenuView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        cell.textLabel?.text = "Menu \(indexPath.row + 1)"
        cell.textLabel?.textColor = .white
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        return cell
    }
}
