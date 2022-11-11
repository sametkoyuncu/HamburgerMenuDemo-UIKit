//
//  Data.swift
//  HamburgerMenuDemo
//
//  Created by fmss on 10.11.2022.
//

import Foundation
import UIKit

enum StoryBoardID: String {
    case green = "HomeVC"
    case purple = "PurpleVC"
}

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

struct Data {
    static var menuData: [MenuSection] = [ .init(isOpen: true,
                                                 title: "Bölüm Bir",
                                                 items: [.init(title: "Home", icon: "house", storyboadID: .green),
                                                         .init(title: "Purple", icon: "phone", storyboadID: .purple)
                                                 ])]
}
