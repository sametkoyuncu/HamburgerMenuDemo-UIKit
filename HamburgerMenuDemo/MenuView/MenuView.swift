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

@IBDesignable
final class MenuView: UIView {
    @IBOutlet private weak var tableView: UITableView!
    
    // for configurations
    weak var delegate: UIViewController?
    
    // Data
    private var menuState: MenuState = .closed
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    init(vc: UIViewController) {
        let frame = CGRect(x: -285, y: 0, width: 280, height: vc.view.frame.height)
        super.init(frame: frame)
        commonInit()
        vc.view.addSubview(self)
        configure(for: vc)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    // TODO: mamşalmapoamof
    func configure(for vc: UIViewController) {
        delegate = vc
        setupGestures()
        navBarConfig()
    }
}

extension MenuView {
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        toggleMenu()
    }
    
    // MARK: - Open or close side menu. | You can call this methods from anywhere if you need.
    func toggleMenu() {
        switch menuState {
        case .opened:
            closeMenu()
            menuState = .closed
        case .closed:
            openMenu()
        }
    }
    
    func openMenu() {
        changeNavBarZPosition(to: -1)
        moveMenuOriginX(to: -5)
        menuState = .opened
    }
    
    func closeMenu() {
        changeNavBarZPosition(to: 0)
        moveMenuOriginX(to: -285)
        menuState = .closed
    }
}

private extension MenuView {
    func commonInit() {
        // connect MenuView.xid file and MenuView.class file
        let bundle = Bundle(for: MenuView.self)
        
        if let viewToAdd = bundle.loadNibNamed("MenuView", owner: self, options: nil), let contentView = viewToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        
        // MARK: - table view config
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "headerCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "rowCell")
    }
    
    // MARK: - Swipe Methods
    @objc func didSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        if menuState == .opened {
            closeMenu()
        }
    }
    
    @objc func didSwipeRight(_ sender: UISwipeGestureRecognizer) {
        if menuState == .closed {
            openMenu()
        }
    }
    
    // MARK: - menu animations
    func moveMenuOriginX(to x: CGFloat) {
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut) { [weak self] in
            self?.frame.origin.x = x
        }
        // for navigation controller pop event
        if x == -5 {
            self.isHidden = false
        } else {
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
