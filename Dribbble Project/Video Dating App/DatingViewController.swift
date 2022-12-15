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
    @IBOutlet weak var imageView: UIImageView!
    private var animator: UIDynamicAnimator!
    private var snapping: UISnapBehavior!
    private let layer = CALayer()
    private var personCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureSnapView(item: imageView)
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
    
    private func configureSnapView(item: UIImageView) {
        imageView = item
        animator = UIDynamicAnimator(referenceView: view)
        snapping = UISnapBehavior(item: item, snapTo: mainView.center)
        animator.addBehavior(snapping)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned))
        item.addGestureRecognizer(panGesture)
        item.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        item.addGestureRecognizer(tapGesture)
    }

    var swiped: Bool = false
    @objc func panned(recognizer: UIPanGestureRecognizer) {
        let rightGap = abs(view.bounds.maxX - imageView.center.x)
        let leftGap = imageView.center.x
        
        switch recognizer.state {
        case .began:
            animator.removeBehavior(snapping)
        case .changed:
            let translation = recognizer.translation(in: mainView)
            imageView.center = CGPoint(x: imageView.center.x + translation.x, y: imageView.center.y)
            
            let normalized = (imageView.center.x - mainView.center.x) / 10
            imageView.transform = CGAffineTransform(rotationAngle: normalized / 180 * CGFloat.pi)
            
            if leftGap < 20 || rightGap < 20 {
                animator.removeBehavior(snapping)
                
                UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in
                    self?.imageView.alpha = 0
                    }, completion: { [weak self] finished in
                        guard finished else { return }
                        self?.imageView.removeFromSuperview()
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
    
    @objc func tapped(_ recognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: SegueModel.datingDetail, sender: self)
    }
    
    private func replaceImage() {
        personCount = (personCount + 1) % 3
        let imageView = UIImageView(image: UIImage(named: "person\(personCount)"))
        imageView.alpha = 0
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.frame = CGRect(origin: CGPoint(x: 20, y: 20), size: CGSize(width: mainView.bounds.width - 40, height: mainView.bounds.height - 40))
        mainView.addSubview(imageView)
        imageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: CGFloat(0.5),
                       initialSpringVelocity: CGFloat(1.0),
                       options: [.allowUserInteraction],
                       animations: {
            imageView.alpha = 1
            imageView.transform = .identity
        })
        
        self.imageView = imageView
        configureSnapView(item: imageView)
    }
    
    @IBAction func closeButtonPressed() {
        navigationController?.dismiss(animated: true)
    }
    
    @IBAction func topButtonPressed(_ sender: UIButton) {
        layer.position = CGPoint(x: sender.center.x, y: sender.center.y + 30)
    }
    
    @IBAction func bottomXpressed(_ sender: UIButton) {
        replaceImage()
    }
    
    
}
