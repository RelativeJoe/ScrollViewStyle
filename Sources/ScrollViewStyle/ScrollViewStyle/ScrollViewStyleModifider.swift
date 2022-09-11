//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//

import SwiftUI
import Introspect
import STools

struct ScrollViewStyleModifider<Style: ScrollViewStyle>: ViewModifier {
    @StateObject var coordinator = ScrollViewCoordinator()
    @State var context = Context(offset: 0)
    let style: Style
    func body(content: Content) -> some View {
        style.makeBody(context: context) {
            WrapperView(content: content, coordinator: coordinator, context: $context, style: style) as! Style.Content
//            GeometryReader { proxy in
//                content
//                    .introspectScrollView { scrollView in
//                        style.makeUIScrollView(scrollView)
//                        scrollView.delegate = coordinator
//                    }.change(of: proxy) { newValue in
//                        context.proxy = newValue
//                    }.change(of: coordinator.offset) { newValue in
//                        context.offset = newValue
//                    }
//            } as! Style.Content
        }
    }
}

public extension ScrollView {
    @ViewBuilder func scrollViewStyle<Style: ScrollViewStyle>(_ style: Style) -> some View where Style.Content == WrapperView<Self, Style> {
        self.modifier(ScrollViewStyleModifider(style: style))
    }
}

public struct WrapperView<Content: View, Style: ScrollViewStyle>: View {
    var content: Content
    @ObservedObject var coordinator: ScrollViewCoordinator
    @Binding var context: Context
    let style: Style
    public var body: some View {
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
        }
    }
}
