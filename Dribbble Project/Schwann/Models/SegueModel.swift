//
//  SegueModel.swift
//  Dribbble Project
//
//  Created by J on 2022-04-23.
//

import Foundation

struct SegueModel {
    static let schwannSegue = "schwannSegue"
}

/// For showing the list of Dribbble projects on the MainVC
enum DesignName: String {
    case schwann = "Schwann"
    
    var segueName: String {
        switch self {
        case .schwann:
            return SegueModel.schwannSegue
        }
    }
}
