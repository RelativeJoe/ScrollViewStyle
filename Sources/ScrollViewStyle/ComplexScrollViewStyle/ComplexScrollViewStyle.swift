//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//

import Foundation
import SwiftUI

@available(iOS 14.0, *)
public struct ComplexScrollViewStyle: ScrollViewStyle {
    public func make(body: AnyView, context: Context) -> some View {
        body
            .preference(key: OffsetPreferenceKey.self, value: context)
    }
    public init() {
    }
    public func makeCoordinator() -> some Delegate {
        return ScrollViewCoordinator()
    }
}
