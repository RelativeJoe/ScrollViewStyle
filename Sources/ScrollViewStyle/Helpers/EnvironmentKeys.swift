//
//  File.swift
//  
//
//  Created by Joe Maghzal on 9/11/22.
//

import SwiftUI

internal struct ContextKey: EnvironmentKey {
    internal static let defaultValue: Context? = nil
}

internal extension EnvironmentValues {
    var prefrenceContext: Context? {
        get {
            self[ContextKey.self]
        }
        set {
            self[ContextKey.self] = newValue
        }
    }
}
