//
//  SwiftUIView.swift
//  
//
//  Created by Joe Maghzal on 9/11/22.
//

import SwiftUI

internal struct AnchorViewModifier: ViewModifier {
    @Binding var context: Context?
//    @State internal var geometryReader: GeometryProxy?
    internal let id: String
    internal func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { reader in
                    Color.clear
                        .onChange(of: reader.frame(in: .scrollView).minX) { _ in
                            let anchor = ReaderAnchor(anchor: id, reader: reader)
                            guard let index = context?.anchors.firstIndex(of: anchor) else {
                                context?.anchors.append(anchor)
                                return
                            }
                            context?.anchors[index] = anchor
                        }
                }
            )//.preference(key: ReaderPreferenceKey.self, value: ReaderAnchor(anchor: id, reader: geometryReader))
    }
}

public extension View {
    @ViewBuilder func anchor(id: CustomStringConvertible, context: Binding<Context?>) -> some View {
        self
            .modifier(AnchorViewModifier(context: context, id: id.description))
    }
}
