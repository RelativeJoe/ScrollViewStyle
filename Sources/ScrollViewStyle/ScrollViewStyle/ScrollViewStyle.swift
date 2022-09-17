//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//
import Foundation
import SwiftUI
import Introspect

public protocol ScrollViewStyle {
    associatedtype Body: View
    associatedtype ScrollContainer: ScrollViewDelegate
    @ViewBuilder @MainActor func make(body: AnyView, context: Context) -> Self.Body
    func make(uiScrollView: UIScrollView)
    func makeCoordinator() -> Self.ScrollContainer
}

internal extension ScrollViewStyle {
    @ViewBuilder @MainActor func makeBody(context: Context, @ViewBuilder content: @escaping () -> some View) -> some View {
        make(body: AnyView(content()), context: context)
    }
}

public extension ScrollViewStyle {
    func make(uiScrollView: UIScrollView) {
    }
    func makeCoordinator() -> some ScrollViewDelegate {
        return ScrollViewCoordinator()
    }
}
