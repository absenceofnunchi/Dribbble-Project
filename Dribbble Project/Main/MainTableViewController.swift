//
//  MainTableViewController.swift
//  Dribbble Project
//
//  Created by J on 2022-04-23.
//

import UIKit
import Combine

final class MainTableViewController: UITableViewController {
    private var dataSource: [String] = DesignName.allCases.map { $0.rawValue }
    private var viewModel = ViewModel()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.actionSubject.send(.initialize)
    }
    
    private func configureCancellable() {
        viewModel.stateEffectSubject
            .sink { [weak self] (stateEffect) in
                switch stateEffect {
                case .initialized:
                    print("initialized")
                case .updateList(list: let list):
                    self?.dataSource = list
                }
            }
            .store(in: &cancellables)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let data = dataSource[indexPath.row]
        cell.textLabel?.text = data
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataSource[indexPath.row]
        guard let designName = DesignName(rawValue: data) else { return }
        self.performSegue(withIdentifier: designName.segueName, sender: self)
    }
}
