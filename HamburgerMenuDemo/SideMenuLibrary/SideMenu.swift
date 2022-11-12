//
//  SideMenu.swift
//  HamburgerMenuDemo
//
//  Created by Samet Koyuncu on 12.11.2022.
//
import UIKit

final class SideMenu: UIView {
    // for configurations
    // TODO: delegate may be use a protocol
    weak var delegate: UIViewController?
    
    // States
    private var menuState: MenuState = .closed
    private var menuPosition: MenuPosition = .left
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(_ menuConfig: MenuConfig) {
        // get view width and x position
        let width = menuConfig.customView.frame.width
        let x = menuConfig.position == .left ? -(width + 5) : menuConfig.vc.view.frame.width + 5
        // create frame using properties for our view
        let frame = CGRect(x: x,
                           y: 0,
                           width: width,
                           height: menuConfig.vc.view.frame.height)
        super.init(frame: frame)
        
        self.isHidden = true
        self.addSubview(menuConfig.customView)
        menuConfig.vc.view.addSubview(self)
        
        // set stored properties
        self.menuPosition = menuConfig.position
        self.delegate = menuConfig.vc
        
        // setup gestures and configure navbar
        setupGestures()
        // TODO: this must be optional and has take custom styles
        navBarConfig()
    }
}

extension SideMenu {
    // MARK: - Open or close side menu. | You can call this methods from anywhere if you need.
    func toggleMenu() {
        switch menuState {
        case .opened:
            closeMenu()
        case .closed:
            openMenu()
        }
    }
    
    func openMenu() {
        changeNavBarStatus(to: .hide)
        updateMenuOriginX(for: .opened)
        menuState = .opened
    }
    
    func closeMenu() {
        changeNavBarStatus(to: .show)
        updateMenuOriginX(for: .closed)
        menuState = .closed
    }
}

private extension SideMenu {
    // MARK: - Swipe Methods
    @objc func didSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        switch menuPosition {
        case .left:
            if menuState == .opened {
                closeMenu()
            }
        case .right:
            if menuState == .closed {
                openMenu()
            }
        }
    }
    
    @objc func didSwipeRight(_ sender: UISwipeGestureRecognizer) {
        switch menuPosition {
        case .left:
            if menuState == .closed {
                openMenu()
            }
        case .right:
            if menuState == .opened {
                closeMenu()
            }
        }
    }
    
    // MARK: - menu animations
    func updateMenuOriginX(for status: MenuState) {
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            switch self.menuPosition {
            case .left:
                self.frame.origin.x = status == .opened ?  -5 : -(self.frame.width + 5)
            case .right:
                self.frame.origin.x = status == .opened ?  self.delegate!.view.frame.width - (self.frame.width - 5) : self.delegate!.view.frame.width + 5
            }
        }
        
        // for navigation controller pop event (-!- delay, important for animations)
        switch status {
        case .opened:
            self.isHidden = false
        case .closed:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.isHidden = true
            }
        }
    }
    
    // MARK: - setup gestures | open or close menu using left and right swipe
    func setupGestures() {
        let swipeGestureRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft(_:)))
        swipeGestureRecognizerLeft.direction = .left
        
        let swipeGestureRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeRight(_:)))
        swipeGestureRecognizerRight.direction = .right
        
        
        delegate?.view.addGestureRecognizer(swipeGestureRecognizerLeft)
        delegate?.view.addGestureRecognizer(swipeGestureRecognizerRight)
    }
    
    // MARK: - navbar config | navbar background color etc.
    func navBarConfig() {
        delegate?.navigationController?.navigationBar.prefersLargeTitles = false
        
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        delegate?.navigationController?.navigationBar.tintColor = .black
        delegate?.navigationController?.navigationBar.standardAppearance = appearance
        delegate?.navigationController?.navigationBar.compactAppearance = appearance
        delegate?.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    // MARK: - Show or hide navigationBar
    func changeNavBarStatus(to status: NavBarStatus) {
        switch status {
        case .show:
            UIView.animate(withDuration: 0.8,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) { [weak self] in
                self?.delegate?.navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: 0)
            }
        case .hide:
            UIView.animate(withDuration: 0.8,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) { [weak self] in
                self?.delegate?.navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: -200)
            }
        }
    }
}

