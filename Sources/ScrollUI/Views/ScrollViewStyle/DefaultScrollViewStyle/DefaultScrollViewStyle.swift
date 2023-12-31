//
//  DefaultScrollViewStyle.swift
//
//
//  Created by Joe Maghzal on 29/07/2023.
//

import SwiftUI

public struct DefaultScrollViewStyle {
//MARK: - Properties
    @Binding private var context: ScrollContext
//MARK: - Initializers
    public init(context: Binding<ScrollContext>) {
        self._context = context
    }
}

//MARK: - ScrollViewStyle
extension DefaultScrollViewStyle: ScrollViewStyle {
    public func makeCoordinator() -> Coordinator {
        return Coordinator(context: $context)
    }
}

extension ScrollViewStyle where Self == DefaultScrollViewStyle {
    static func defaultStyle(context: Binding<ScrollContext>) -> DefaultScrollViewStyle {
        return DefaultScrollViewStyle(context: context)
    }
}
