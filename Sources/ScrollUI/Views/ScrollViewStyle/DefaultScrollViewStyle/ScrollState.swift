//
//  ScrollState.swift
//
//
//  Created by Joe Maghzal on 31/12/2023.
//

import SwiftUI

@propertyWrapper public struct ScrollState: DynamicProperty {
//MARK: - Properties
    @State private var context = ScrollContext()
//MARK: - Initializer
    public init() {
    }
//MARK: - ComputedProperties
    public var wrappedValue: ScrollContext {
        get {
            return context
        }
        nonmutating set {
            context = newValue
        }
    }
    public var projectedValue: Binding<ScrollContext> {
        return $context
    }
}
