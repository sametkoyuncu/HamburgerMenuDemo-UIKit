//
//  SideMenuModel.swift
//  HamburgerMenuDemo
//
//  Created by Samet Koyuncu on 12.11.2022.
//
import UIKit

enum MenuState {
    case opened
    case closed
}

enum MenuPosition {
    case left
    case right
}

struct MenuConfig {
    var vc: UIViewController
    var customView: UIView
    var position: MenuPosition = .left
}
