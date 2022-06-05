//
//  CollectionViewable+Protocol.swift
//  Dribbble Project
//
//  Created by J on 2022-06-05.
//

import UIKit

protocol CollectionViewable {
    associatedtype Category: Hashable
    associatedtype CategoryModel: Hashable
    var dataSource: UICollectionViewDiffableDataSource<Category, CategoryModel>! { get set }
    var modelArray: [[CategoryModel]]! { get set }
    func configureHierarchy()
    func configureDataSource()
    func generateLayout() -> UICollectionViewLayout
}
