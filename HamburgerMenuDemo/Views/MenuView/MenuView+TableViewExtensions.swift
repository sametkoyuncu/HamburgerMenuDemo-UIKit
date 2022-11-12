//
//  MenuTableView+Extensions.swift
//  HamburgerMenuDemo
//
//  Created by fmss on 10.11.2022.
//

import UIKit

private var menuData = Data.menuData

// MARK: - TableView Delegate Methods
extension MenuView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let section = menuData.sections[indexPath.section]
        if indexPath.row == 0 {
            menuData.sections[indexPath.section].isOpen = !section.isOpen
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .automatic)
        } else if menuData.selectedItem != section.items[indexPath.row - 1].title {
            toggleMenu?()
            let selectedItem = section.items[indexPath.row-1]
            // update selected item
            menuData.selectedItem = selectedItem.title
            
            // navigation
            var vc: UIViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            switch selectedItem.storyboadID {
            case .green:
                vc = storyboard.instantiateViewController(withIdentifier: selectedItem.storyboadID.rawValue) as! ViewController
            case .purple:
                vc = storyboard.instantiateViewController(withIdentifier: selectedItem.storyboadID.rawValue) as! PurpleViewController
            }
            
            delegate?.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

// MARK: - TableView DataSource Methods
extension MenuView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        menuData.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuData.sections[section].isOpen ? menuData.sections[section].items.count + 1 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") else {
                return UITableViewCell()
            }
            let item = menuData.sections[indexPath.section]
            
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
            
            let item = menuData.sections[indexPath.section].items[indexPath.row - 1]
            
            cell.backgroundColor = .clear
    
            cell.textLabel?.text = item.title
            cell.textLabel?.textColor = .darkGray
            cell.imageView?.image = UIImage(systemName: item.icon)
            cell.tintColor = .darkGray
            cell.layer.cornerRadius = 8
            
            // TODO: all cell disabled after collapse and expand section
            if menuData.selectedItem == item.title {
                //cell.isUserInteractionEnabled = false
                cell.backgroundColor = .lightGray
                cell.tintColor = .white
                cell.textLabel?.textColor = .white
            }
            
            return cell
        }
    }
}

