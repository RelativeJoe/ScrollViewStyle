//
//  BindedSnapCarouselView.swift
//  
//
//  Created by Joe Maghzal on 21/07/2023.
//

import SwiftUI

struct BindedSnapCarouselView<Content: View>: View {
//MARK: - Properties
    @State private var itemWidth = CGFloat.zero
    @State private var scrollEffects = ScrollEffect.zero
    @State private var size = CGSize.zero
    @State private var gesturePadding = CGFloat.zero
    @Binding var selection: Int
    let itemsCount: Int
    let content: Content
    let withScrollBouncing: Bool
    let axis: Axis
    let spacing: CGFloat
    let animation: Animation
    let dynamicGesture: Bool
    let maxBounce: CGFloat?
    let gestureEnabled: (() -> Bool)?
//MARK: - Mappings
    private var index: Int {
        let index = max(min(selection, itemsCount - 1), 0)
        if index != selection {
            selection = index
        }
        return index
    }
    private var reachedEnd: Bool {
        return selection == (itemsCount - 1)
    }
    private var reachedStart: Bool {
        return selection == 0
    }
//MARK: - Body
    var body: some View {
        GeometryReader { proxy in
            stack {
                content
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .blur(radius: scrollEffects.blurRadius)
                    .opacity(scrollEffects.opacity)
                    .brightness(scrollEffects.brightness)
            }.padding(axis == .vertical ? .top: .leading, padding(for: proxy))
            .padding(axis == .vertical ? .top: .leading, gesturePadding)
            .simultaneousGesture(dragGesture)
            .onAppear {
                itemWidth = -proxy.size.value(for: axis) - spacing
                size = proxy.size
            }
        }.edgesIgnoringSafeArea(.all)
        .animation(animation, value: index)
    }
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { newValue in
                guard dynamicGesture, gestureEnabled?() ?? true else {return}
                let offset = newValue.translation.value(for: axis)
                let addition = offset < 0
                if addition && reachedEnd || !addition && reachedStart {
                    guard withScrollBouncing, abs(offset) < maxBounce ?? 1000 else {return}
                }
                gesturePadding = max(min(offset, abs(itemWidth)), itemWidth)
            }.onEnded { newValue in
                guard gestureEnabled?() ?? true else {return}
                let offset = newValue.translation.value(for: axis)
                let addition = offset < 0
                if let nextIndex = nextIndex(addition: addition), abs(offset) > 150 {
                    gesturePadding = 0
                    selection = nextIndex
                }else {
                    withAnimation {
                        gesturePadding = 0
                    }
                }
            }
    }
//MARK: - Functions
    private func nextIndex(addition: Bool) -> Int? {
        let newIndex = selection + (addition ? 1: -1)
        guard newIndex >= 0 && newIndex < itemsCount else {
            return nil
        }
        return newIndex
    }
    private func padding(for proxy: GeometryProxy) -> CGFloat {
        return itemWidth * CGFloat(index)
    }
    @ViewBuilder private func stack(@ViewBuilder view: () -> some View) -> some View {
        if axis == .horizontal {
            LazyHStack(spacing: spacing) {
                view()
            }
        }else {
            LazyVStack(spacing: spacing) {
                view()
            }
        }
    }
}

struct ScrollEffect {
    var blurRadius: CGFloat
    var opacity: CGFloat
    var brightness: CGFloat
    static let zero = ScrollEffect(blurRadius: 0, opacity: 1, brightness: 0)
}
