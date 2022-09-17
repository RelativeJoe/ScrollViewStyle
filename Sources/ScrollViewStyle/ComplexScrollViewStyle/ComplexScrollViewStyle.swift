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
//            .preference(key: OffsetPreferenceKey.self, value: context)
//            .environment(\.prefrenceContext, context)
    }
    public init() {
    }
    public func makeCoordinator() -> some Delegate {
        return ScrollViewCoordinator()
    }
}

public struct ScrollViewContainer<Content: View>: View {
    @State internal var context: Context? = Context(offset: .zero)
    @ViewBuilder public var content: (Binding<Context?>) -> Content
    public var body: some View {
        content($context)
    }
}
