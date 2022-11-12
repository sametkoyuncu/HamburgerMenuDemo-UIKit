//
//  Data.swift
//  HamburgerMenuDemo
//
//  Created by fmss on 10.11.2022.
//

import UIKit

// Menu List
struct MenuItem {
    var title = String()
    var icon = "info.circle"
    var storyboadID: StoryBoardID
}

struct MenuSection {
    var isOpen: Bool = false
    var title = String()
    var items: [MenuItem]
}

struct MenuData {
    var sections: [MenuSection]
    var selectedItem: String?
}

enum StoryBoardID: String {
    case green = "HomeVC"
    case purple = "PurpleVC"
}

struct Data {
    static var menuSections: [MenuSection] = [ .init(isOpen: true,
                                                 title: "Bölüm Bir",
                                                 items: [.init(title: "Home", icon: "house", storyboadID: .green),
                                                         .init(title: "Purple", icon: "phone", storyboadID: .purple)
                                                 ])]
    static var menuData = MenuData(sections: menuSections, selectedItem: menuSections.first?.items.first?.title ?? "Home")
}
