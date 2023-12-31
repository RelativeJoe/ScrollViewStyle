//
//  SnapCarouselView.swift
//  
//
//  Created by Joe Maghzal on 27/05/2023.
//

import SwiftUI

public struct SnapCarouselView<Content: View>: View {
//MARK: - Properties
    @State private var stateSelection = 0
    @Binding private var bindingSelection: Int
    private let binded: Bool
    private let itemsCount: Int
    private let content: Content
    private let withScrollBouncing: Bool
    private let axis: Axis
    private let spacing: CGFloat
    private let animation: Animation
    private let dynamicGesture: Bool
    private let maxBounce: CGFloat?
    private let gestureEnabled: (() -> Bool)?
//MARK: - Mappings
    private var selection: Binding<Int> {
        Binding {
            binded ? bindingSelection: stateSelection
        } set: { newValue in
            if binded {
                bindingSelection = newValue
            }else {
                stateSelection = newValue
            }
        }
    }
//MARK: - Body
    public var body: some View {
        BindedSnapCarouselView(selection: selection, itemsCount: itemsCount, content: content, withScrollBouncing: withScrollBouncing, axis: axis, spacing: spacing, animation: animation, dynamicGesture: dynamicGesture, maxBounce: maxBounce, gestureEnabled: gestureEnabled)
    }
}

//MARK: - Initializers
public extension SnapCarouselView {
    init(_ axis: Axis, spacing: CGFloat = 0, count: Int, @ViewBuilder content: () -> Content) {
        self.binded = false
        self._bindingSelection = .constant(0)
        self.itemsCount = count
        self.content = content()
        self.withScrollBouncing = false
        self.axis = axis
        self.spacing = spacing
        self.animation = .spring()
        self.dynamicGesture = false
        self.maxBounce = nil
        self.gestureEnabled = nil
    }
    init(_ axis: Axis, spacing: CGFloat = 0, count: Int, selection: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.binded = true
        self._bindingSelection = selection
        self.itemsCount = count
        self.content = content()
        self.withScrollBouncing = false
        self.axis = axis
        self.spacing = spacing
        self.animation = .spring()
        self.dynamicGesture = false
        self.maxBounce = nil
        self.gestureEnabled = nil
    }
}

//MARK: - Modifiers
public extension SnapCarouselView {
    func bounces(_ bounces: Bool = true, maxOffset: CGFloat? = nil) -> Self {
        SnapCarouselView(bindingSelection: $bindingSelection, binded: binded, itemsCount: itemsCount, content: content, withScrollBouncing: bounces, axis: axis, spacing: spacing, animation: animation, dynamicGesture: dynamicGesture, maxBounce: maxOffset, gestureEnabled: gestureEnabled)
    }
    func dynamicGesture(_ dynamicGesture: Bool = true) -> Self {
        SnapCarouselView(bindingSelection: $bindingSelection, binded: binded, itemsCount: itemsCount, content: content, withScrollBouncing: withScrollBouncing, axis: axis, spacing: spacing, animation: animation, dynamicGesture: dynamicGesture, maxBounce: maxBounce, gestureEnabled: gestureEnabled)
    }
    func with(animation: Animation) -> Self {
        SnapCarouselView(bindingSelection: $bindingSelection, binded: binded, itemsCount: itemsCount, content: content, withScrollBouncing: withScrollBouncing, axis: axis, spacing: spacing, animation: animation, dynamicGesture: dynamicGesture, maxBounce: maxBounce, gestureEnabled: gestureEnabled)
    }
    func gestureEnabled(_ condition: @escaping () -> Bool) -> Self {
        SnapCarouselView(bindingSelection: $bindingSelection, binded: binded, itemsCount: itemsCount, content: content, withScrollBouncing: withScrollBouncing, axis: axis, spacing: spacing, animation: animation, dynamicGesture: dynamicGesture, maxBounce: maxBounce, gestureEnabled: condition)
    }
}
