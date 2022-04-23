//
//  MainTableViewController.swift
//  Dribbble Project
//
//  Created by J on 2022-04-23.
//

import UIKit
import Combine

class MainTableViewController: UITableViewController {
    private var dataSource: [String] = [
        DesignName.schwann.rawValue
    ]
    private var viewModel = ViewModel()
    private var cancellables = Set<AnyCancellable>()


    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /// Initialize the UI to 0 face detected upon load
        viewModel.actionSubject.send(.initialize)
    }
    

    private func configureUI() {
    }
    
    private func configureCancellable() {
        /// When face detect request returns obervations, the number of obervations updates the counter in view model, which in turn emits state effect to update the UI accordingly.

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
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        switch segue.identifier {
//        case SegueModel.schwannSegue:
//            guard let vc = segue.destination as? SchwannViewController else {
//                return
//            }
//
//        default:
//            break
//        }
    }
}
