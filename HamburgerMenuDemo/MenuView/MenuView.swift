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

enum MenuPosition: CGFloat {
    case left = -1
    case right = 1
}

@IBDesignable
final class MenuView: UIView {
    @IBOutlet private weak var tableView: UITableView!
    
    // for configurations
    weak var delegate: UIViewController?
    
    // Data
    private var menuState: MenuState = .closed
    private var menuPosition: MenuPosition = .left
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    init(vc: UIViewController, width: CGFloat, position: MenuPosition = .left) {
        self.menuPosition = position
        delegate = vc
        let x = position == .left ? -(width + 5) : vc.view.frame.width + 5
        let frame = CGRect(x: x,
                           y: 0,
                           width: width,
                           height: vc.view.frame.height)
        
        super.init(frame: frame)
        commonInit()
        
        self.isHidden = true
        vc.view.addSubview(self)
        
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
        case .closed:
            openMenu()
        }
    }
    
    func openMenu() {
        changeNavBarZPosition(to: -1)
        updateMenuOriginX(for: .opened)
        menuState = .opened
    }
    
    func closeMenu() {
        changeNavBarZPosition(to: 0)
        updateMenuOriginX(for: .closed)
        menuState = .closed
    }
}

private extension MenuView {
    func commonInit() {
        // connect MenuView.xib file and MenuView.class file
        let bundle = Bundle(for: MenuView.self)
        
        if let viewToAdd = bundle.loadNibNamed("MenuView", owner: self, options: nil), let contentView = viewToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        
        // table view config
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "headerCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "rowCell")
    }
    
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
        
        // for navigation controller pop event, delay important for animations
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
