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
        if indexPath.row == 0 {
            menuData[indexPath.section].isOpen = !menuData[indexPath.section].isOpen
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .automatic)
        } else {
            closeMenu()
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "SecondVC") as! SecondViewController
//            delegate?.navigationController?.pushViewController(vc, animated: true)
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

