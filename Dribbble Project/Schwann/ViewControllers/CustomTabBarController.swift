//
//  CustomTabBarController.swift
//  Dribbble Project
//
//  Created by J on 2022-04-23.
//
// https://github.com/keyhan76/RaisedMiddleTabBarButton/blob/main/CustomTabBar/CustomTabBarController.swift

import UIKit

final class CustomTabBarController: UITabBarController {
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false

        tabBar.backgroundColor = .systemBackground
//        tabBar.tintColor = #colorLiteral(red: 0.05700000003, green: 0.09799999744, blue: 0.1070000008, alpha: 1)
        
        delegate = self
        
        // Instantiate view controllers
        let homeNav = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerName.SchwannViewController) as! SchwannViewController
        let settingsNav = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerName.TaskViewController) as! TaskViewController

        // Create TabBar items
        homeNav.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        settingsNav.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        
        // Assign viewControllers to tabBarController
        let viewControllers = [homeNav, settingsNav]
        self.setViewControllers(viewControllers, animated: false)
        
        guard let tabBar = self.tabBar as? CustomTabBar else { return }
        
        tabBar.didTapButton = { [unowned self] in
            self.routeToCalendarVC()
        }
    }
    
    func routeToCalendarVC() {
        let newPostVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerName.CalendarViewController) as! CalendarViewController
        newPostVC.modalPresentationCapturesStatusBarAppearance = true
        self.present(newPostVC, animated: true, completion: nil)
    }
}

// MARK: - UITabBarController Delegate
extension CustomTabBarController: UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        guard let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else {
//            return true
//        }
//
//        // Your middle tab bar item index.
//        // In my case it's 1.
//        if selectedIndex == 1 {
//            return false
//        }
//
//        return true
//    }
}

class CustomTabBar: UITabBar {
    
    // MARK: - Variables
    public var didTapButton: (() -> ())?
    
    public lazy var middleButton: UIButton! = {
        let middleButton = UIButton()
        
        middleButton.frame.size = CGSize(width: 48, height: 48)
        
        let image = UIImage(systemName: "plus")!
        middleButton.setImage(image, for: .normal)
        middleButton.backgroundColor = #colorLiteral(red: 0.00334105012, green: 0.4572779536, blue: 0.8895364404, alpha: 1)
        middleButton.tintColor = .white
        middleButton.layer.cornerRadius = middleButton.bounds.size.width / 2
        
        middleButton.addTarget(self, action: #selector(self.middleButtonAction), for: .touchUpInside)
        
        self.addSubview(middleButton)
        
        return middleButton
    }()
    
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.4
        self.layer.masksToBounds = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        middleButton.center = CGPoint(x: frame.width / 2, y: -5)
    }
    
    // MARK: - Actions
    @objc func middleButtonAction(sender: UIButton) {
        didTapButton?()
    }
    
    // MARK: - HitTest
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        
        return self.middleButton.frame.contains(point) ? self.middleButton : super.hitTest(point, with: event)
    }
}
