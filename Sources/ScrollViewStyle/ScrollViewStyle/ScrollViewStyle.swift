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
//    associatedtype Content: View
    @ViewBuilder @MainActor func body(content: AnyView, context: Context) -> Self.Body
    func makeUIScrollView(_ scrollView: UIScrollView)
    func coordinator() -> ScrollViewCoordinator
}

internal extension ScrollViewStyle {
    @ViewBuilder @MainActor func makeBody(context: Context, @ViewBuilder content: @escaping () -> some View) -> some View {
        body(content: AnyView(content()), context: context)
    }
}

public extension ScrollViewStyle {
    func coordinator() -> ScrollViewCoordinator {
        return ScrollViewCoordinator()
    }
}
