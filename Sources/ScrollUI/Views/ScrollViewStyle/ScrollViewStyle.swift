//
//  ScrollViewStyle.swift
//  
//
//  Created by Joe Maghzal on 29/07/2023.
//

import Foundation
import SwiftUI
import Introspect
import Combine

public protocol ScrollViewStyle {
    associatedtype ScrollCoordinator: UIScrollViewDelegate & ObservableObject
    func make(uiScrollView: UIScrollView)
    func makeCoordinator() -> ScrollCoordinator
}

public extension ScrollViewStyle {
    func make(uiScrollView: UIScrollView) {
    }
}
