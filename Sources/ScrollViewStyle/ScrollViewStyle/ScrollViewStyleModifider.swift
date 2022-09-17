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
    @StateObject internal var coordinator: Style.ScrollContainer
    @State internal var context = Context(offset: .zero)
    internal let style: Style
    internal init(style: Style) {
        self.style = style
        self._coordinator = StateObject(wrappedValue: style.makeCoordinator())
    }
    internal func body(content: Content) -> some View {
        style.makeBody(context: context) {
            GeometryReader { proxy in
                content
                    .coordinateSpace(name: "ScrollView")
                    .introspectScrollView { scrollView in
                        style.make(uiScrollView: scrollView)
                        scrollView.delegate = coordinator
                    }.change(of: proxy) { newValue in
                        context.proxy = newValue
                    }.change(of: coordinator.offset) { newValue in
                        context.offset = newValue
                    }.onPreferenceChange(ReaderPreferenceKey.self) { value in
                        guard let anchor = value else {return}
                        guard let index = context.anchors.firstIndex(of: anchor) else {
                            context.anchors.append(anchor)
                            return
                        }
                        context.anchors[index] = anchor
                    }
            }// as! Style.Content
        }
    }
}

public extension View {
    @ViewBuilder func scrollViewStyle<Style: ScrollViewStyle>(_ style: Style) -> some View {
        self.modifier(ScrollViewStyleModifider(style: style))
    }
}
