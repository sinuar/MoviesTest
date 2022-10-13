//
//  ViewModelState.swift
//  TheMovieDB
//
//  Created by Sinuhé Ruedas on 12/10/22.
//

import Foundation

@propertyWrapper
class ViewModelState<State> {
    var projectedValue: ViewModelState<State> { self }
    
    /// State
    var wrappedValue: State {
        didSet {
            observer?(wrappedValue)
        }
    }
    
    /// Observer
    var observer: ((State) -> Void)? {
        didSet {
            observer?(wrappedValue)
        }
    }
    
    init(wrappedValue: State) {
        self.wrappedValue = wrappedValue
    }
    
}
