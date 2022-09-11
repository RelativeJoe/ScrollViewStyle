//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//

import Foundation
import SwiftUI

@available(iOS 14.0, *)
public struct ComplexScrollViewStyle<Content: View>: ScrollViewStyle {
    public func body(content: AnyView, context: Context) -> some View {
        content
            .preference(key: OffsetPreferenceKey.self, value: context)
    }
    public func makeUIScrollView(_ scrollView: UIScrollView) {
        print(scrollView.frame)
    }
    public init() {
    }
}
