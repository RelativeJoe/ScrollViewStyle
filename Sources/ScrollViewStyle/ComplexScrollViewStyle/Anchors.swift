//
//  SwiftUIView.swift
//  
//
//  Created by Joe Maghzal on 9/11/22.
//

import SwiftUI

public extension View {
    @ViewBuilder func anchor<T: CustomStringConvertible>(id: T) -> some View {
        self
            .modifier(AnchorViewModifier(id: id.description))
    }
}

struct AnchorViewModifier: ViewModifier {
    @State var geometryReader: GeometryProxy?
    let id: String
    func body(content: Content) -> some View {
        self
            .background {
                GeometryReader { reader in
                    Color.clear
                        .onChange(of: reader) { reader in
                            geometryReader = reader
                        }
                }
            }.preference(key: ReaderPreferenceKey.self, value: ReaderAnchor(anchor: id, reader: geometryReader))
    }
}
