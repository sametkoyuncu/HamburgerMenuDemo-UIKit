//
//  Data.swift
//  HamburgerMenuDemo
//
//  Created by fmss on 10.11.2022.
//

import Foundation


struct MenuItem {
    var title = String()
    var icon = "info.circle"
}

struct MenuSection {
    var isOpen: Bool = false
    var title = String()
    var items: [MenuItem]
}

struct Data {
    static  var menuData: [MenuSection] = [ .init(isOpen: true,
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
}
