//
//  CarouselView.swift
//  
//
//  Created by Joe Maghzal on 21/07/2023.
//

import SwiftUI

struct CarouselView<ID: Hashable & Identifiable, Content: View>: View {
//MARK: - Properties
    @State private var appeared = false
    @State private var size = CGFloat.zero
    @Binding var selection: ID?
    let showsIndicators: Bool
    let itemSize: CGFloat
    let axis: Axis
    let data: [ID]
    let spacing: CGFloat
    let horizontalAlignment: HorizontalAlignment
    let verticalAlignment: VerticalAlignment
    let content: (ID) -> Content
    let onSelection: ((ID) -> Void)?
    let shouldSelect: ((ID) -> Bool)?
    let selectionMap: ((ID) -> ID?)?
//MARK: - Body
    var body: some View {
        GeometryReader { geometryProxy in
            let padding = abs(geometryProxy.size.value(for: axis)/2 - (spacing + size/2))
            ScrollViewReader { scrollProxy in
                ScrollView(axis.axisSet, showsIndicators: showsIndicators) {
                    stack {
                        Color.clear
                            .frame(width: padding)
                        ForEach(data) { item in
                            HStack(spacing: 0) {
                                Color.clear
                                    .frame(width: spacing)
                                content(item)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        onSelection?(item)
                                        selection = item
                                        select(item, scrollProxy: scrollProxy)
                                    }.opacity(item == selection ? 1: 0.5)
                            }.id(item)
                        }
                        Color.clear
                            .frame(width: padding)
                    }.onScroll(axis) { newValue in
                        onScroll(newValue, scrollProxy: scrollProxy)
                    }.onScrollEnd { newValue in
                        select(selection, scrollProxy: scrollProxy)
                    }
                }.coordinateSpace(name: "scroll")
            }
        }
    }
}

//MARK: - Functions
private extension CarouselView {
    @ViewBuilder func stack(@ViewBuilder view: () -> some View) -> some View {
        if axis == .horizontal {
            HStack(alignment: verticalAlignment, spacing: spacing) {
                view()
            }
        }else {
            VStack(alignment: horizontalAlignment, spacing: spacing) {
                view()
            }
        }
    }
    func onScroll(_ newValue: CGFloat, scrollProxy: ScrollViewProxy) {
        guard appeared else {
            select(selection, scrollProxy: scrollProxy)
            appeared = true
            return
        }
        let factor = itemSize + spacing
        var approximateIndex = Int(round(newValue/factor))
        if approximateIndex > (data.count - 1) {
            approximateIndex = data.count - 1
        }
        if approximateIndex < 0 {
            approximateIndex = 0
        }
        if Int(round(newValue)) % Int(factor) == 0 && selection != data[approximateIndex] {
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
        let newSelection = data[approximateIndex]
        if selection == newSelection || selection == nil {
            selection = newSelection
            selection = nil
        }
    }
    func select(_ item: ID?, scrollProxy: ScrollViewProxy) {
        guard let selectionItem = item ?? data.first, shouldSelect?(selectionItem) ?? true else {return}
        selection = selectionMap?(selectionItem) ?? item
        withAnimation(.easeIn) {
            scrollProxy.scrollTo(selection, anchor: .leading)
        }
    }
}
