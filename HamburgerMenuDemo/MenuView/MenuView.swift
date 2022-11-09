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

struct MenuItem {
    var title = String()
    var icon = "info.circle"
}

struct MenuSection {
    var isOpen: Bool = false
    var title = String()
    var items: [MenuItem]
}

@IBDesignable
class MenuView: UIView {
    
    weak var delegate: UIViewController?
    @IBOutlet weak var tableView: UITableView!
    
    // Data
    var menuState: MenuState = .closed
    var menuData: [MenuSection] = [ .init(isOpen: true,
                                          title: "Bölüm Bir",
                                          items: [.init(title: "Item 1", icon: "house"),
                                                  .init(title: "Item 2", icon: "phone"),
                                                  .init(title: "Item 3", icon: "photo"),
                                                  .init(title: "Item 4", icon: "xmark"),
                                          ]),
                                    .init(isOpen: false,
                                          title: "Bölüm İki",
                                          items: [.init(title: "Item 1", icon: "house"),
                                                  .init(title: "Item 2", icon: "phone"),
                                                  .init(title: "Item 3", icon: "photo"),
                                          ]),
                                    .init(isOpen: false,
                                          title: "Bölüm Üç",
                                          items: [.init(title: "Item 1", icon: "house"),
                                                  .init(title: "Item 2", icon: "phone"),
                                                  .init(title: "Item 3", icon: "photo"),
                                                  .init(title: "Item 4", icon: "xmark"),
                                                  .init(title: "Item 5"),
                                          ]),
    ]
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        toggleMenu()
    }
    
    // MARK: - Open or close side menu. | You can call this from anywhere if you need.
    func toggleMenu() {
        switch menuState {
        case .opened:
            
            changeNavBarZPosition(to: 0)
            moveMenuOriginX(to: -285)
            menuState = .closed
        case .closed:
            changeNavBarZPosition(to: -1)
            moveMenuOriginX(to: -5)
            menuState = .opened
        }
    }
}

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
        tableView.separatorStyle = .none
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "headerCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "rowCell")
    }
    
    // menu animation
    func moveMenuOriginX(to x: CGFloat) {
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut) { [weak self] in
            self?.frame.origin.x = x
        }
    }
    
    // MARK: - Show or hide navigationBar
    func changeNavBarZPosition(to position: CGFloat) {
        if position == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.delegate?.navigationController?.navigationBar.layer.zPosition = position;
            }
            delegate?.navigationController?.navigationBar.isUserInteractionEnabled = true
        } else {
            delegate?.navigationController?.navigationBar.layer.zPosition = position;
            delegate?.navigationController?.navigationBar.isUserInteractionEnabled = false
        }
    }
}


// MARK: - TableView Delegate Methods
extension MenuView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            menuData[indexPath.section].isOpen = !menuData[indexPath.section].isOpen
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .automatic)
        }
    }
}

// MARK: - TableView DataSource Methods
extension MenuView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        menuData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuData[section].isOpen ? menuData[section].items.count + 1 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") else {
                return UITableViewCell()
            }
            let item = menuData[indexPath.section]
            
            cell.backgroundColor = .clear
            
            cell.textLabel?.text = item.title
            cell.textLabel?.textColor = .black
            let iconImage: UIImageView = .init(image: UIImage(systemName: item.isOpen ? "chevron.up" : "chevron.down"))
            cell.accessoryView = iconImage
            cell.tintColor = .black
            
            return cell
            
        } else {
            // use different cell if needed
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "rowCell") else {
                return UITableViewCell()
            }
            
            let item = menuData[indexPath.section].items[indexPath.row - 1]
            
            cell.backgroundColor = .clear
            
            cell.textLabel?.text = item.title
            cell.textLabel?.textColor = .darkGray
            cell.imageView?.image = UIImage(systemName: item.icon)
            cell.tintColor = .darkGray
            
            return cell
        }
    }
}
