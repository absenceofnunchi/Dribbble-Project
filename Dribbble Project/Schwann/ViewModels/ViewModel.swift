//
//  ViewModel.swift
//  Dribbble Project
//
//  Created by J on 2022-04-23.
//

import Foundation
import Combine

final class ViewModel {
    /// Counter represents the number of faces currently detected
    private struct State {
        var list: [String] = []
    }

    /// Action created by a view controller
    enum Action {
        case initialize /// When a view controller is newly loaded
        case updateList(item: String)
        case updateError
    }
    
    /// The resulting state from the action to be reflected in the UI
    enum StateEffect {
        case initialized /// When a view controller is newly loaded, the UI will reflect 0 face detected
        case updateList(list: [String])
    }

    /// Value only has to be passed once per state change
    var stateEffectSubject = CurrentValueSubject<StateEffect, Never>(.initialized)
    /// Continuous action execution depending on the number of face detected
    var actionSubject = PassthroughSubject<Action, Never>()

    private var state = State()
    private var cancellables = Set<AnyCancellable>()

    init() {
        setupCancellables()
    }

    private func setupCancellables() {
        /// Listens to the actions sent by the view controller
        actionSubject
            .sink { [weak self] action in
                guard let self = self else { return }

                switch action {
                case .initialize:
                    self.state.list = []
                case .updateList(let item):
                    self.state.list.append(item)
                case .updateError:
                    print("error")
                }
                
                /// Send the number of face currently detected to the view controller for the UI
                self.stateEffectSubject.send(
                    .updateList(list: self.state.list)
                )
            }
            .store(in: &cancellables)
    }
}

