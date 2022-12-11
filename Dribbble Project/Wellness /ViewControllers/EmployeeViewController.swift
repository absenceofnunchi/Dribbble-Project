//
//  EmployeeViewController.swift
//  Dribbble Project
//
//  Created by Jeff Choi on 2022-12-10.
//

import UIKit

final class EmployeeViewController: UIViewController {
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var bottomContainerConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureView()
    }
    
    private func configureView() {
        bottomContainerConstraint?.isActive = false
        self.bottomContainerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 10).isActive = true
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    @IBAction func closePressed() {
        dismiss(animated: true)
    }
}
