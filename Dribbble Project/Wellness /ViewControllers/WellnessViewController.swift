//
//  WellnessViewController.swift
//  Dribbble Project
//
//  Created by Jeff Choi on 2022-12-09.
//

import UIKit

class WellnessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func closePressed(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
}
