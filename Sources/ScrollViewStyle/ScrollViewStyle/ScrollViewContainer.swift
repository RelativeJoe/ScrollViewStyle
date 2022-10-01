//
//  File.swift
//  
//
//  Created by Joe Maghzal on 9/17/22.
//

import SwiftUI

public struct ScrollViewContainer<Content: View>: View {
    @State internal var context: Context? = Context(offset: .zero, differentialOffset: .zero)
    internal var content: (Binding<Context?>) -> Content
    public init(@ViewBuilder content: @escaping (Binding<Context?>) -> Content) {
        self.content = content
    }
    public var body: some View {
        content($context)
    }
}
