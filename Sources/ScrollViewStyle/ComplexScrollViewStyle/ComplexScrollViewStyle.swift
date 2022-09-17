//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//

import Foundation
import SwiftUI

public struct ComplexScrollViewStyle: ScrollViewStyle {
    public func make(body: AnyView, context: Context) -> some View {
        body
//            .preference(key: OffsetPreferenceKey.self, value: context)
//            .environment(\.prefrenceContext, context)
    }
    public init() {
    }
    public func makeCoordinator() -> some ScrollViewDelegate {
        return ScrollViewCoordinator()
    }
}
