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
    static let dating: String = "datingSegue"
    static let datingDetail: String = "datingDetailSegue"
}

/// For showing the list of Dribbble projects on the MainVC
enum DesignName: String, CaseIterable {
    case schwann = "Schwann"
    case welless = "Wellness"
    case dating = "Video Dating App"
    
    var segueName: String {
        switch self {
        case .schwann:
            return SegueModel.schwannSegue
        case .welless:
            return SegueModel.wellness
        case .dating:
            return SegueModel.dating
        }
    }
}

