//
//  File.swift
//  
//
//  Created by Joe Maghzal on 9/11/22.
//

import SwiftUI

struct ReaderPreferenceKey: PreferenceKey {
    static var defaultValue: ReaderAnchor?
    static func reduce(value: inout ReaderAnchor?, nextValue: () -> ReaderAnchor?) {
        value = nextValue()
    }
}

public struct OffsetPreferenceKey: PreferenceKey {
    public static var defaultValue: Context?
    public static func reduce(value: inout Context?, nextValue: () -> Context?) {
        value = nextValue()
    }
}
