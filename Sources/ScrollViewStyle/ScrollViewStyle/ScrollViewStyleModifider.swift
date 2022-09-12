//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//

import SwiftUI
import Introspect
import STools

internal struct ScrollViewStyleModifider<Style: ScrollViewStyle>: ViewModifier {
    @StateObject internal var coordinator = ScrollViewCoordinator()
    @State internal var context = Context(offset: 0)
    internal let style: Style
    internal func body(content: Content) -> some View {
        style.makeBody(context: context) {
            GeometryReader { proxy in
                content
                    .introspectScrollView { scrollView in
                        style.makeUIScrollView(scrollView)
                        scrollView.delegate = coordinator
                    }.change(of: proxy) { newValue in
                        context.proxy = newValue
                    }.change(of: coordinator.offset) { newValue in
                        context.offset = newValue
                    }
            }// as! Style.Content
        }
    }
}

public extension ScrollView {
    @ViewBuilder func scrollViewStyle<Style: ScrollViewStyle>(_ style: Style) -> some View {
        self.modifier(ScrollViewStyleModifider(style: style))
    }
}
