//
//  DatingViewController.swift
//  Dribbble Project
//
//  Created by Jeff Choi on 2022-12-12.
//  https://dribbble.com/shots/20106814-Video-Dating-App

import UIKit

class DatingViewController: UIViewController {
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var userInfoView: UserInfoWrapperView!
    private var dataSource: [DatingUserModel] = []
    private var animator: UIDynamicAnimator!
    private var snapping: UISnapBehavior!
    private let layer = CALayer()
    private var personCount: Int = 0
    private var swiped: Bool = false
    private var viewModel = DatingUserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        configureView()
        guard let userInfo = dataSource.first else { return }
        setUserInfo(userInfo: userInfo, userInfoView: userInfoView.contentView)
        
//        let textField = UINib(nibName: "\(self)", bundle: nil).instantiate(withOwner: nil, options: nil)[1] as? UILabel

//        configureSnapView(item: userInfoView)
        
    }
    
    @discardableResult
    private func setUserInfo(userInfo: DatingUserModel, userInfoView: UserInfoView) -> UserInfoView {
        userInfoView.locationLabel.text = userInfo.location
        userInfoView.nameLabel.text = userInfo.name
        userInfoView.ageLabel.text = "\(userInfo.age)"
        userInfoView.image = userInfo.image
        userInfoView.layer.cornerRadius = 20
        userInfoView.clipsToBounds = true
        return userInfoView
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    var menuItems: [UIAction] {
        return [
            UIAction(title: "Profile", image: UIImage(systemName: "sun.max"), handler: { (_) in
            }),
            UIAction(title: "Settings", image: UIImage(systemName: "moon"), attributes: .disabled, handler: { (_) in
            }),
            UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { (_) in
            })
        ]
    }
    
    var barButtonMenu: UIMenu {
        return UIMenu(title: "Main Menu", image: nil, identifier: nil, options: [], children: menuItems)
    }
    
    private func configureView() {
        let leftBarImage = UIImage(systemName: "line.3.horizontal.decrease")
        let barImageView = UIImageView(image: leftBarImage)
        barImageView.tintColor = UIColor.white
        
        let barButtonItem = UIBarButtonItem(title: "Menu", image: leftBarImage, primaryAction: nil, menu: barButtonMenu)
        barButtonItem.tintColor = UIColor.white
        
        navigationItem.leftBarButtonItem = barButtonItem
        
        layer.backgroundColor = UIColor.white.cgColor
        topStackView.layer.addSublayer(layer)
        guard let firstButton = topStackView.arrangedSubviews.first else { return }
        layer.frame = CGRect(origin: .zero, size: CGSize(width: 30, height: 1))
        layer.position = CGPoint(x: firstButton.center.x, y: firstButton.center.y + 30)
    }
    
    private func configureSnapView(item: UserInfoView) {
        userInfoView.contentView = item
        animator = UIDynamicAnimator(referenceView: view)
        snapping = UISnapBehavior(item: item, snapTo: mainView.center)
        animator.addBehavior(snapping)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned))
        item.addGestureRecognizer(panGesture)
        item.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        item.addGestureRecognizer(tapGesture)
    }
    
    private func configureData() {
        viewModel.users.bind { _ in
            
        }
        
        dataSource = [
            DatingUserModel(name: "Erin Vetroves", age: 27, location: "New York / USA", tags: ["#trovel", "#fashion", "#nature"], image: UIImage(named: "person0")!),
            DatingUserModel(name: "Erin Vetroves", age: 27, location: "New York / USA", tags: ["#trovel", "#fashion", "#nature"], image: UIImage(named: "person1")!),
            DatingUserModel(name: "Erin Vetroves", age: 27, location: "New York / USA", tags: ["#trovel", "#fashion", "#nature"], image: UIImage(named: "person2")!),
        ]
    }
    
    @objc func panned(recognizer: UIPanGestureRecognizer) {
        let rightGap = abs(view.bounds.maxX - userInfoView.center.x)
        let leftGap = userInfoView.center.x
        
        switch recognizer.state {
        case .began:
            animator.removeBehavior(snapping)
        case .changed:
            let translation = recognizer.translation(in: mainView)
            userInfoView.center = CGPoint(x: userInfoView.center.x + translation.x, y: userInfoView.center.y)
            
            let normalized = (userInfoView.center.x - mainView.center.x) / 10
            userInfoView.transform = CGAffineTransform(rotationAngle: normalized / 180 * CGFloat.pi)
            
            if leftGap < 20 || rightGap < 20 {
                animator.removeBehavior(snapping)
                
                UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in
                    self?.userInfoView.alpha = 0
                }, completion: { [weak self] finished in
                    guard finished else { return }
                    self?.userInfoView.removeFromSuperview()
                }
                )
                self.swiped = true
            } else {
                recognizer.setTranslation(.zero, in: view)
            }
        case .ended, .cancelled, .failed:
            if swiped {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.replaceImage()
                }
            } else {
                animator.addBehavior(snapping)
            }
            
            swiped = false
        case .possible:
            break
        @unknown default:
            fatalError()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == SegueModel.datingDetail,
              let vc = segue.destination as? DatingDetailViewController else {
            return
        }
        
        let userInfoView = UserInfoView(image: UIImage(named: "person\(personCount)"))
        userInfoView.contentMode = .scaleAspectFill
        vc.view.addSubview(userInfoView)
        vc.view.sendSubviewToBack(userInfoView)
        userInfoView.frame = vc.view.bounds
    }
    
    @objc func tapped(_ recognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: SegueModel.datingDetail, sender: self)
    }
    
    private func replaceImage() {
        personCount = (personCount + 1) % 3
        let userInfoView = UserInfoView(image: UIImage(named: "person\(personCount)"))
        userInfoView.alpha = 0
        userInfoView.layer.cornerRadius = 20
        userInfoView.clipsToBounds = true
        userInfoView.frame = CGRect(origin: CGPoint(x: 20, y: 20), size: CGSize(width: mainView.bounds.width - 40, height: mainView.bounds.height - 40))
        mainView.addSubview(userInfoView)
        userInfoView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: CGFloat(0.5),
                       initialSpringVelocity: CGFloat(1.0),
                       options: [.allowUserInteraction],
                       animations: {
            userInfoView.alpha = 1
            userInfoView.transform = .identity
        })
        
        self.userInfoView.contentView = userInfoView
        configureSnapView(item: userInfoView)
    }
    
    private func configureUserInfoView(userInfo: DatingUserModel) {
        let userInfoView = UserInfoView.loadViewFromNib()
        userInfoView.frame = CGRect(origin: CGPoint(x: 20, y: 20), size: CGSize(width: mainView.bounds.width - 40, height: mainView.bounds.height - 40))
        mainView.addSubview(userInfoView)
        setUserInfo(userInfo: userInfo, userInfoView: userInfoView)
    }
    
    @IBAction func closeButtonPressed() {
        navigationController?.dismiss(animated: true)
    }
    
    @IBAction func topButtonPressed(_ sender: UIButton) {
        layer.position = CGPoint(x: sender.center.x, y: sender.center.y + 30)
    }
    
    @IBAction func bottomXpressed(_ sender: UIButton) {
        userInfoView?.removeFromSuperview()
        replaceImage()
    }
}
