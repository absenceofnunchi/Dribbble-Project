//
//  DatingUserModel.swift
//  Dribbble Project
//
//  Created by Jeff Choi on 2022-12-17.
//

import UIKit

struct DatingUserModel {
    let name: String
    let age: Int
    let location: String
    let tags: [String]
    let image: UIImage
}

struct DatingUserViewModel {
    var users: Observable<[DatingUserModel]> = Observable([])
}
