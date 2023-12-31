//
//  VerticalCarouselView.swift
//  
//
//  Created by Joe Maghzal on 21/07/2023.
//

import SwiftUI

public struct VerticalCarouselView<ID: Hashable & Identifiable, Content: View>: View {
//MARK: - Properties
    @Binding private var selection: ID?
    private let showsIndicators: Bool
    private let data: [ID]
    private let spacing: CGFloat
    private let alignment: HorizontalAlignment
    private let content: (ID) -> Content
    private var onSelection: ((ID) -> Void)?
    private var shouldSelect: ((ID) -> Bool)?
    private var selectionMap: ((ID) -> ID?)?
    private let itemHeight: CGFloat
//MARK: - Body
    public var body: some View {
        CarouselView(selection: $selection, showsIndicators: showsIndicators, itemSize: itemHeight, axis: .vertical, data: data, spacing: spacing, horizontalAlignment: alignment, verticalAlignment: .center, content: content, onSelection: onSelection, shouldSelect: shouldSelect, selectionMap: selectionMap)
    }
}

//MARK: - Initializers
public extension VerticalCarouselView {
    init(_ showsIndicators: Bool, alignment: HorizontalAlignment, spacing: CGFloat, itemHeight: CGFloat, data: [ID], selection: Binding<ID?>, @ViewBuilder content: @escaping (ID) -> Content) {
        self._selection = selection
        self.showsIndicators = showsIndicators
        self.data = data
        self.spacing = spacing
        self.alignment = alignment
        self.content = content
        self.itemHeight = itemHeight
    }
}

//MARK: - Modifiers
public extension VerticalCarouselView {
    func onSelection(_ action: @escaping (ID) -> Void) -> Self {
        return VerticalCarouselView(selection: $selection, showsIndicators: showsIndicators, data: data, spacing: spacing, alignment: alignment, content: content, onSelection: action, shouldSelect: shouldSelect, selectionMap: selectionMap, itemHeight: itemHeight)
    }
    func shouldSelect(_ action: @escaping (ID) -> Bool) -> Self {
        return VerticalCarouselView(selection: $selection, showsIndicators: showsIndicators, data: data, spacing: spacing, alignment: alignment, content: content, onSelection: onSelection, shouldSelect: action, selectionMap: selectionMap, itemHeight: itemHeight)
    }
    func map(_ action: @escaping (ID) -> ID?) -> Self {
        return VerticalCarouselView(selection: $selection, showsIndicators: showsIndicators, data: data, spacing: spacing, alignment: alignment, content: content, onSelection: onSelection, shouldSelect: shouldSelect, selectionMap: action, itemHeight: itemHeight)
    }
}
