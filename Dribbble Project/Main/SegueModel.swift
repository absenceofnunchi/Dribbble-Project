//
//  SegueModel.swift
//  Dribbble Project
//
//  Created by J on 2022-04-23.
//

import Foundation

struct SegueModel {
    static let schwannSegue: String = "schwannSegue"
    static let wellness: String = "wellnessSegue"
}

/// For showing the list of Dribbble projects on the MainVC
enum DesignName: String, CaseIterable {
    case schwann = "Schwann"
    case welless = "Wellness"
    
    var segueName: String {
        switch self {
        case .schwann:
            return SegueModel.schwannSegue
        case .welless:
            return SegueModel.wellness
        }
    }
}
