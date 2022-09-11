//
//  SwiftUIView.swift
//  
//
//  Created by Joe Maghzal on 9/11/22.
//

import SwiftUI

extension View {
    @ViewBuilder func anchor<T: CustomStringConvertible>(id: T) -> some View {
        GeometryReader { reader in
            self
                .preference(key: ReaderPreferenceKey.self, value: ReaderAnchor(anchor: id.description, reader: reader))
        }
    }
}
