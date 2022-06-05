//
//  TaskViewController.swift
//  Dribbble Project
//
//  Created by J on 2022-04-23.
//

import UIKit

class SectionModel: Hashable, Equatable {
    var section: Section
    var title: String
    
    init(section: Section, title: String) {
        self.section = section
        self.title = title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    static func == (lhs: SectionModel, rhs: SectionModel) -> Bool {
        return true
    }
}

class FirstSectionModel: SectionModel {
    let subTitle: String
    let progress: Int
    let days: Int
    
    init(section: Section, title: String, subTitle: String, progress: Int, days: Int) {
        self.subTitle = subTitle
        self.progress = progress
        self.days = days
        super.init(section: section, title: title)
    }
}

class SecondSectionModel: SectionModel {
    let symbol: String
    let taskNumber: Int
    let date: String
    
    init(section: Section, title: String, symbol: String, taskNumber: Int, date: String) {
        self.symbol = symbol
        self.taskNumber = taskNumber
        self.date = date
        super.init(section: section, title: title)
    }
}

enum Section: Int, CaseIterable {
    case ongoingTasks
    case category
    
    var value: String {
        switch self {
        case .ongoingTasks:
            return "Ongoing Tasks"
        case .category:
            return "Category"
        }
    }
}

class TaskViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var progressView: ProgressView!
    
    typealias Category = Section
    typealias CategoryModel = SectionModel
    
    var dataSource: UICollectionViewDiffableDataSource<Section, SectionModel>! = nil
    var modelArray: [[SectionModel]]! = [
        [
            FirstSectionModel(section: .ongoingTasks, title: "Mobile UIKit", subTitle: "Odama Studio", progress: 76, days: 3),
            FirstSectionModel(section: .ongoingTasks, title: "Illustration", subTitle: "Paperpillar", progress: 82, days: 5),
        ],
        [
            SecondSectionModel(section: .category, title: "UI Design", symbol: "flame.fill", taskNumber: 24, date: "5/24"),
            SecondSectionModel(section: .category, title: "Illustration", symbol: "wand.and.stars", taskNumber: 18, date: "7/18")
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureHierarchy()
        configureDataSource()
    }

    private func configureUI() {
        progressView.progressAnimation(duration: 2)
    }
}

extension TaskViewController: UICollectionViewDelegate {
    func configureHierarchy() {
        collectionView.collectionViewLayout = generateLayout()
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        collectionView.delegate = self
    }
    
    func configureDataSource() {
        let TaskCellRegistration = UICollectionView.CellRegistration<TaskCollectionViewCell, FirstSectionModel> { (cell, indexPath, sectionModel) in
            cell.titleLabel.text = sectionModel.title
            cell.moreSymbol.setImage(UIImage(systemName: "ellipsis")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), for: .normal)
            cell.subtitleLabel.text = sectionModel.subTitle
            cell.progressLabel.text = "Progress"
            cell.percentageLabel.text = "\(sectionModel.progress)%"
            cell.dateLabel.text = "\(sectionModel.days) Days left"
        }
        
        let CategoryRegistration = UICollectionView.CellRegistration<CategoryCollectionViewCell, SecondSectionModel> { (cell, indexPath, sectionModel) in
            cell.imageView.image = UIImage(systemName: sectionModel.symbol)?.withTintColor(.red, renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration(pointSize: 11))
            cell.button.setImage(UIImage(systemName: "ellipsis")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), for: .normal)
            cell.titleLabel.text = sectionModel.title
            cell.subtitleLabel.text = "\(sectionModel.taskNumber) Tasks"
            cell.dateLabel.text = sectionModel.date
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, SectionModel>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: SectionModel) -> UICollectionViewCell? in

            if  Section(rawValue: indexPath.section)! == .ongoingTasks {
                let item = identifier as? FirstSectionModel
                return collectionView.dequeueConfiguredReusableCell(using: TaskCellRegistration, for: indexPath, item: item)
            } else {
                let item = identifier as? SecondSectionModel
                return collectionView.dequeueConfiguredReusableCell(using: CategoryRegistration, for: indexPath, item: item)
            }
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <TextCell>(elementKind: "Menu") { [weak self] (supplementaryView, string, indexPath) in
            guard let data = self?.modelArray[indexPath.section][indexPath.item] else { return }
            supplementaryView.label.text = data.section.value
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration, for: index)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, SectionModel>()
        Section.allCases.forEach { [weak self] section in
            snapshot.appendSections([section])
            guard let filteredMenuDataArray = self?.modelArray[section.rawValue].filter ({ $0.section == section }) else { return }
            snapshot.appendItems(filteredMenuDataArray)
        }

        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension TaskViewController: CollectionViewable {
 
    /// - Tag: PerSection
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in
            let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500
            return self.generateHorizontalLayout(isWide: isWideView)
//            let sectionLayoutKind = Section.allCases[sectionIndex]
//            switch (sectionLayoutKind) {
//                case .ongoingTasks: return self.generateHorizontalLayout(isWide: isWideView)
//                case .ongoingTasks: return self.generateHorizontalLayout(isWide: isWideView)
//            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 50
        layout.configuration = config
        return layout
    }
    
    private func generateHorizontalLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5)
        
        let groupFractionalWidth: CGFloat = isWide ? 0.5 : 0.7
        let groupFractionalHeight: CGFloat = isWide ? 1/2 : 3/7
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupFractionalWidth),
            heightDimension: .fractionalHeight(groupFractionalHeight)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .estimated(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: "Menu",
            alignment: .top)
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 30
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        return section
    }
}
