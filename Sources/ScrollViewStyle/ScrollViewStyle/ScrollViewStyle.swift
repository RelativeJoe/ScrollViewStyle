//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//
import Foundation
import SwiftUI
import Introspect

@available(iOS 13.0, *)
public protocol ScrollViewStyle {
    associatedtype Body: View
    associatedtype Content: View
    @ViewBuilder @MainActor func body(content: Self.Content, context: Context) -> Self.Body
    func makeUIScrollView(_ scrollView: UIScrollView)
}

@available(iOS 13.0, *)
internal extension ScrollViewStyle {
    @ViewBuilder @MainActor func makeBody(context: Context, @ViewBuilder content: @escaping () -> Self.Content) -> some View {
        body(content: content(), context: context)
    }
}
