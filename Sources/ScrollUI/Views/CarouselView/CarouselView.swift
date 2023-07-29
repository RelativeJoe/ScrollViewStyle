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
    @Binding var selection: ID
    let showsIndicators: Bool
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
                            GeometryReader { internalGeometryReader in
                                content(item)
                                    .id(item)
                                    .onTapGesture {
                                        onSelection?(item)
                                        select(item, scrollProxy: scrollProxy)
                                    }.onAppear {
                                        size = internalGeometryReader.size.value(for: axis)
                                    }
                            }
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
        let factor = size + spacing
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
        selection = data[approximateIndex]
    }
    func select(_ item: ID, scrollProxy: ScrollViewProxy) {
        guard shouldSelect?(item) ?? true else {return}
        selection = selectionMap?(item) ?? item
        withAnimation(.easeIn) {
            scrollProxy.scrollTo(selection, anchor: .bottom)
        }
    }
}
