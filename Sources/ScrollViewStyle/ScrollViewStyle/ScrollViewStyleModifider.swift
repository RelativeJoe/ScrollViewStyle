//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//

import SwiftUI
import Introspect
import STools

innternal struct ScrollViewStyleModifider<Style: ScrollViewStyle>: ViewModifier {
    @StateObject innternal var coordinator = ScrollViewCoordinator()
    @State innternal var context = Context(offset: 0)
    innternal let style: Style
    innternal func body(content: Content) -> some View {
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
