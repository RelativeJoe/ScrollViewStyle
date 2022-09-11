//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//

import SwiftUI
import Introspect

@available(iOS 14.0, *)
struct ScrollViewStyleModifider<Style: ScrollViewStyle>: ViewModifier {
    @StateObject var coordinator = ScrollViewCoordinator()
    @State var context = Context(offset: 0)
    let style: Style
    func body(content: Content) -> some View {
        style.makeBody(context: context) {
            VStack {
                GeometryReader { proxy in
                    content
                        .introspectScrollView { scrollView in
                            style.makeUIScrollView(scrollView)
                            scrollView.delegate = coordinator
                        }.onChange(of: proxy) { newValue in
                            context.proxy = newValue
                        }.onChange(of: coordinator.offset) { newValue in
                            context.offset = newValue
                        }
                }
            }
        }
    }
}
