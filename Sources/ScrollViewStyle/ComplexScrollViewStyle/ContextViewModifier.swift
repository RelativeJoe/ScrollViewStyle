//
//  File.swift
//  
//
//  Created by Joe Maghzal on 9/11/22.
//

import SwiftUI

struct ContextViewModifier: ViewModifier {
    @State var context: Context?
    func body(content: Content) -> some View {
        content
            .environment(\.prefrenceContext, context)
            .onPreferenceChange(OffsetPreferenceKey.self) { value in
               context = value
            }.onPreferenceChange(ReaderPreferenceKey.self) { value in
                guard let anchor = value else {return}
                guard let index = context?.anchors.firstIndex(of: anchor) else {
                    context?.anchors.append(anchor)
                    return
                }
                context?.anchors[index] = anchor
            }
    }
}

public extension View {
    @ViewBuilder func scrollContainer() -> some View {
        self
            .modifier(ContextViewModifier())
    }
}
