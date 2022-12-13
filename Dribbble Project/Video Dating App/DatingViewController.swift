//
//  DatingViewController.swift
//  Dribbble Project
//
//  Created by Jeff Choi on 2022-12-12.
//

import UIKit

class DatingViewController: UIViewController {
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var topStackView: UIStackView!
    let layer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        let leftBarButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let leftBarImage = UIImage(systemName: "line.3.horizontal.decrease")
        leftBarButton.tintColor = UIColor.white
        leftBarButton.setImage(leftBarImage, for: .normal)
        leftBarButton.layer.cornerRadius = 5
        leftBarButton.backgroundColor = UIColor.gray
        leftBarButtonItem.customView = leftBarButton
        
        layer.backgroundColor = UIColor.white.cgColor
        topStackView.layer.addSublayer(layer)
        guard let firstButton = topStackView.arrangedSubviews.first else { return }
        layer.frame = CGRect(origin: .zero, size: CGSize(width: 30, height: 1))
        layer.position = CGPoint(x: firstButton.center.x, y: firstButton.center.y + 30)
    }
    
    @IBAction func closeButtonPressed() {
        navigationController?.dismiss(animated: true)
    }
    
    @IBAction func topButtonPressed(_ sender: UIButton) {
        layer.position = CGPoint(x: sender.center.x, y: sender.center.y + 30)
    }
}
