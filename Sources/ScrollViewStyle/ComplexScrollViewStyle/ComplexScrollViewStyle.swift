//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//

import Foundation
import SwiftUI

public struct ComplexScrollViewStyle: ScrollViewStyle {
    let bouncing: ScrollAxis?
    public func make(body: AnyView, context: Context) -> some View {
        body
//            .preference(key: OffsetPreferenceKey.self, value: context)
//            .environment(\.prefrenceContext, context)
    }
    public init(bouncing: ScrollAxis? = [.vertical, .horizontal]) {
        self.bouncing = bouncing
    }
    public func make(uiScrollView: UIScrollView) {
        if let bouncing {
            uiScrollView.bounces = true
            uiScrollView.alwaysBounceVertical = bouncing.contains(.vertical)
            uiScrollView.alwaysBounceHorizontal = bouncing.contains(.horizontal)
        }else {
            uiScrollView.bounces = false
        }
    }
    public func makeCoordinator() -> some ScrollViewDelegate {
        return ScrollViewCoordinator()
    }
}
