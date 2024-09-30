//
//  ScrollViewStyleModifider.swift
//  
//
//  Created by Joe Maghzal on 29/07/2023.
//

import SwiftUI
import SwiftUIIntrospect

internal struct ScrollViewStyleModifider<Style: ScrollViewStyle>: ViewModifier {
    @StateObject internal var coordinator: Style.ScrollCoordinator
    internal let style: Style
    internal init(style: Style) {
        self.style = style
        self._coordinator = StateObject(wrappedValue: style.makeCoordinator())
    }
    internal func body(content: Content) -> some View {
        content
            .introspect(.scrollView, on: .iOS(.v13, .v14, .v15, .v16, .v17 , .v18)) { scrollView in
                style.make(uiScrollView: scrollView)
                scrollView.delegate = coordinator
            }
    }
}

//MARK: - Public Modifier
public extension View {
    @ViewBuilder func scrollViewStyle<Style: ScrollViewStyle>(_ style: Style) -> some View {
        modifier(ScrollViewStyleModifider(style: style))
    }
}
