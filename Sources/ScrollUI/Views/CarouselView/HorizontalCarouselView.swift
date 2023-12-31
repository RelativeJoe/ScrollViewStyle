//
//  HorizontalCarouselView.swift
//  
//
//  Created by Joe Maghzal on 21/07/2023.
//

import SwiftUI

public struct HorizontalCarouselView<ID: Hashable & Identifiable, Content: View>: View {
//MARK: - Properties
    @Binding private var selection: ID?
    private let showsIndicators: Bool
    private let data: [ID]
    private let spacing: CGFloat
    private let alignment: VerticalAlignment
    private let content: (ID) -> Content
    private var onSelection: ((ID) -> Void)?
    private var shouldSelect: ((ID) -> Bool)?
    private var selectionMap: ((ID) -> ID?)?
    private let itemWidth: CGFloat
//MARK: - Body
    public var body: some View {
        CarouselView(selection: $selection, showsIndicators: showsIndicators, itemSize: itemWidth, axis: .horizontal, data: data, spacing: spacing, horizontalAlignment: .center, verticalAlignment: alignment, content: content, onSelection: onSelection, shouldSelect: shouldSelect, selectionMap: selectionMap)
    }
}

//MARK: - Initializers
public extension HorizontalCarouselView {
    init(_ showsIndicators: Bool, alignment: VerticalAlignment, spacing: CGFloat, itemWidth: CGFloat, data: [ID], selection: Binding<ID?>, @ViewBuilder content: @escaping (ID) -> Content) {
        self._selection = selection
        self.showsIndicators = showsIndicators
        self.data = data
        self.spacing = spacing
        self.alignment = alignment
        self.content = content
        self.itemWidth = itemWidth
    }
}

//MARK: - Modifiers
public extension HorizontalCarouselView {
    func onSelection(_ action: @escaping (ID) -> Void) -> Self {
        return HorizontalCarouselView(selection: $selection, showsIndicators: showsIndicators, data: data, spacing: spacing, alignment: alignment, content: content, onSelection: action, shouldSelect: shouldSelect, selectionMap: selectionMap, itemWidth: itemWidth)
    }
    func shouldSelect(_ action: @escaping (ID) -> Bool) -> Self {
        return HorizontalCarouselView(selection: $selection, showsIndicators: showsIndicators, data: data, spacing: spacing, alignment: alignment, content: content, onSelection: onSelection, shouldSelect: action, selectionMap: selectionMap, itemWidth: itemWidth)
    }
    func map(_ action: @escaping (ID) -> ID?) -> Self {
        return HorizontalCarouselView(selection: $selection, showsIndicators: showsIndicators, data: data, spacing: spacing, alignment: alignment, content: content, onSelection: onSelection, shouldSelect: shouldSelect, selectionMap: action, itemWidth: itemWidth)
    }
}
