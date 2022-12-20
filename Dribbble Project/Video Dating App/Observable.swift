//
//  Observable.swift
//  Dribbble Project
//
//  Created by Jeff Choi on 2022-12-17.
//

import Foundation

struct Observable<T> {
    private var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    mutating func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
