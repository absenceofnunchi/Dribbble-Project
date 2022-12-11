//
//  WellnessViewController.swift
//  Dribbble Project
//
//  Created by Jeff Choi on 2022-12-09.
//  Original design: https://dribbble.com/shots/20088872-Wellness-Mobile-IOS-App-for-employees

import UIKit

final class WellnessViewController: UIViewController {

    @IBOutlet weak var elementView1: UIView! /// top left "care about your" view
    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var elementView2: UIView!
    @IBOutlet weak var elementView3: UIView!
    @IBOutlet weak var employeLabel: UILabel!
    @IBOutlet weak var buttonViewContainer: UIView!
    @IBOutlet weak var buttonView: UIView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateSplash()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureInitialState()
    }
    
    private func configureInitialState() {
        elementView1.transform = CGAffineTransform(translationX: -250, y: 50).rotated(by: -45 / 180.0 * CGFloat.pi)
        stackView1.alpha = 0
        
        elementView2.transform = CGAffineTransform(translationX: 250, y: 50).rotated(by: 45 / 180.0 * CGFloat.pi)
        elementView3.transform = CGAffineTransform(translationX: -250, y: 20)
        employeLabel.transform = CGAffineTransform(translationX: 100, y: 20)
        employeLabel.alpha = 0
        
        buttonViewContainer.transform = CGAffineTransform(translationX: 500, y: 0)
        buttonView.transform = CGAffineTransform(translationX: 500, y: 0)
    }
    
    private func animateSplash() {
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .calculationModeCubicPaced, animations: { [weak self] in
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3) {
                self?.elementView1?.transform = .identity
                self?.elementView2?.transform = .identity
                self?.elementView3?.transform = .identity
            }

            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self?.stackView1.alpha = 1
                self?.employeLabel.transform = .identity
                self?.employeLabel.alpha = 1
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self?.buttonViewContainer.transform = .identity
                self?.buttonView.transform = .identity
            }
        })
    }
    
    @IBAction func tapped() {
        UIView.animate(withDuration: 1) { [weak self] in
            self?.buttonView.transform = CGAffineTransform(translationX: 1000, y: 0)
        } completion: { [weak self] _ in
            self?.performSegue(withIdentifier: "employeeSegue", sender: self)
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
}
