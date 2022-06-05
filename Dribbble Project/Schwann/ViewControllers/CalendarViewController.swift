//
//  CalendarViewController.swift
//  Dribbble Project
//
//  Created by J on 2022-04-23.
//

import UIKit

enum CalendarSection: Int, CaseIterable {
    case schedule
    
    var value: String {
        switch self {
        case .schedule:
            return "Schedule"
        }
    }
}

class CalendarModel: Hashable, Equatable {
    var section: CalendarSection
    var title: String
    
    init(section: CalendarSection, title: String) {
        self.section = section
        self.title = title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    static func == (lhs: CalendarModel, rhs: CalendarModel) -> Bool {
        return true
    }
}

class CalendarViewController: UIViewController {
    @IBOutlet weak var topCollectionView: UICollectionView!
    
    typealias Category = CalendarSection
    typealias CategoryModel = CalendarModel
    
    var dataSource: UICollectionViewDiffableDataSource<CalendarSection, CalendarModel>! = nil
    var modelArray: [[CalendarModel]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureHierarchy()
        configureDataSource()
    }
    
    private func configureUI() {
        topCollectionView.register(UINib(nibName: "CalendarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "calendar-cell-reusable-identifier")
    }
}

extension CalendarViewController: UICollectionViewDelegate {
    func configureHierarchy() {
        
    }
    
    func configureDataSource() {
    }
}

extension CalendarViewController: CollectionViewable {
    func generateLayout() -> UICollectionViewLayout {
        return UICollectionViewLayout()
    }
}

//class CalendarViewController: UIViewController {
//    @IBOutlet weak var topCollectionView: UICollectionView!
//    let size = CGSize(width: 200, height: 100)
//     var v1: UIView!
//     var v2: UIView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.v1 = UIView(frame: .init(origin: .init(x: 100, y: 100), size: size))
//        self.view.addSubview(self.v1)
//        self.v1.backgroundColor = .orange
//        self.v2 = UIView(frame: .init(origin: .init(x: 100, y: 300), size: size))
//        self.view.addSubview(v2)
//        self.view.addSubview(self.v2)
//        self.v2.backgroundColor = .purple
//
//        let verticalGesture = VerticalGesture(target: self, action: #selector(dragged))
//        self.v2.addGestureRecognizer(verticalGesture)
//
//        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(tapped))
//        longPress.minimumPressDuration = 0.5
//        longPress.delaysTouchesBegan = true
//        longPress.delegate = self
//        self.view.addGestureRecognizer(longPress)
//    }
//
//    @objc func dragged(_ sender: VerticalGesture) {
//
//    }
//
//    @objc func tapped(_ sender: UIGestureRecognizer) {
//
//    }
//}
//
//extension CalendarViewController: UIGestureRecognizerDelegate {
//    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
//        if gestureReconizer.state != UIGestureRecognizer.State.ended {
//            //When lognpress is start or running
//        }
//        else {
//            //When lognpress is finish
//        }
//    }
//}
