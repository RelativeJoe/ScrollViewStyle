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
    @Binding var bindingContext: Context?
    @State internal var context = Context(offset: .zero, differentialOffset: .zero)
    internal let style: Style
    internal init(style: Style, context: Binding<Context?> = .constant(nil)) {
        self.style = style
        self._coordinator = StateObject(wrappedValue: style.makeCoordinator())
        self._bindingContext = context
    }
    internal func body(content: Content) -> some View {
        style.makeBody(context: context) {
            content
                .introspectScrollView { scrollView in
                    style.make(uiScrollView: scrollView)
                    scrollView.delegate = coordinator
                }.background(
                    GeometryReader { proxy in
                        Color.clear
                            .change(of: proxy) { newValue in
                                context.proxy = newValue
                            }
                    }
                ).change(of: coordinator.offset) { newValue in
                    context.offset = newValue
                    context.differentialOffset = coordinator.differentialOffset
                }
//                .onPreferenceChange(ReaderPreferenceKey.self) { value in
//                    guard let anchor = value else {return}
//                    guard let index = context.anchors.firstIndex(of: anchor) else {
//                        context.anchors.append(anchor)
//                        return
//                    }
//                    context.anchors[index] = anchor
//                }
                .onChange(of: context) { newValue in
                    guard bindingContext != nil else {return}
                    bindingContext?.update(newValue)
                }
        }
    }
}

//MARK: - Public Modifier
public extension View {
    @ViewBuilder func scrollViewStyle<Style: ScrollViewStyle>(_ style: Style, context: Binding<Context?> = .constant(nil)) -> some View {
        self
            .coordinateSpace(name: "ScrollView")
            .modifier(ScrollViewStyleModifider(style: style, context: context))
    }
}
