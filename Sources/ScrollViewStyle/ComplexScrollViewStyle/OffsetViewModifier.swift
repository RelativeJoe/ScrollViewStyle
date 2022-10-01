//
//  File.swift
//  
//
//  Created by Joe Maghzal on 9/11/22.
//

import SwiftUI
import STools

internal struct OffsetViewModifier {
    //MARK: - Properties
    private let offsets: [OffsetType]
    private let oldHeight: CGFloat?
    private let oldWidth: CGFloat?
    private let alignment: Alignment?
    @State private var newHeight: CGFloat?
    @State private var newWidth: CGFloat?
    @State private var padding: (Edge.Set, CGFloat) = (.top, 0)
    @State private var offsetValue: (CGFloat, CGFloat) = (0, 0)
    @Binding internal var context: Context?
    //    @Environment(\.prefrenceContext) private var context
}

//MARK: - Internal Initializer
internal extension OffsetViewModifier {
    init(_ offsets: [OffsetType], oldHeight: CGFloat?, oldWidth: CGFloat?, alignment: Alignment?, context: Binding<Context?>) {
        self.offsets = offsets
        self.oldHeight = oldHeight
        self.oldWidth = oldWidth
        self.alignment = alignment
        self._newHeight = State(wrappedValue: oldHeight)
        self._newWidth = State(wrappedValue: oldWidth)
        self._context = context
    }
}

//MARK: - Internal Functions
internal extension OffsetViewModifier {
    func setNewValue(_ value: CGFloat?, size: SizeChange) {
        if size == .height {
            newHeight = value
        }else {
            newWidth = value
        }
    }
}

//MARK: - ViewModifier
extension OffsetViewModifier: ViewModifier {
    internal func body(content: Content) -> some View {
        GeometryReader { proxy in
            content
                .onChange(of: context) { value in
                    withAnimation(.none) {
                        
                    }
                    guard let context = value else {
                        return
                    }
                    guard context.offset.y > 0 || context.offset.x > 0 else {
                        padding.1 = 0
                        newHeight = oldHeight
                        newWidth = oldWidth
                        offsetValue.0 = 0
                        offsetValue.1 = 0
                        return
                    }
                    offsets.forEach { offset in
                        switch offset {
                            case .offset(let offset):
                                withAnimation(offset.animation) {
                                    //MARK: - Padding Values
                                    var newOffset = context.offset.getValue(offset.axis ?? .vertical) * (offset.speed ?? 100)/100
                                    //MARK: - Padding Conditions
                                    if let minValue = offset.minValue {
                                        guard padding.1 > minValue else {return}
                                    }
                                    if let direction = offset.direction {
                                        guard context.direction == direction else {return}
                                    }
                                    if let maxValue = offset.maxValue {
                                        guard newOffset < maxValue else {return}
                                    }
                                    if let minOffset = offset.minOffset {
                                        guard newOffset > minOffset else {return}
                                    }
                                    if offset.invertedOffset {
                                        newOffset = -newOffset
                                    }
                                    //MARK: - Offset Logic
                                    if let anchor = offset.anchor {
                                        guard let anchorView = context.anchors.first(where: {$0.anchor == anchor}), let point = anchorView.reader?.frame(in: .global).getValue(offset.position ?? .max, axis: offset.axis ?? offset.edge) else {return}
                                        guard point != proxy.frame(in: .global).getValue(offset.position ?? .max, axis: offset.axis ?? offset.edge) else {
                                            return
                                        }
                                    }
                                    if offset.edge.contains(.horizontal) {
                                        offsetValue.0 = newOffset
                                    }
                                    if offset.edge.contains(.vertical) {
                                        offsetValue.1 = newOffset
                                    }
                                }
                            case .padding(let paddingValue):
                                withAnimation(paddingValue.animation) {
                                    //MARK: - Padding Values
                                    var newPadding = context.offset.getValue(paddingValue.axis ?? .vertical) * (paddingValue.speed ?? 100)/100
                                    //MARK: - Padding Conditions
                                    if let minValue = paddingValue.minValue {
                                        guard padding.1 > minValue else {return}
                                    }
                                    if let direction = paddingValue.direction {
                                        guard context.direction == direction else {return}
                                    }
                                    if let minOffset = paddingValue.minOffset {
                                        guard newPadding > minOffset else {return}
                                    }
                                    if let maxValue = paddingValue.maxValue {
                                        guard newPadding < maxValue else {return}
                                    }
                                    if paddingValue.invertedOffset {
                                        newPadding = -newPadding
                                    }
                                    //MARK: - Padding Logic
                                    padding.0 = paddingValue.edge
                                    padding.1 = newPadding
                                }
                            case .resize(let resize):
                                withAnimation(resize.animation) {
                                    //MARK: - Resize Values
                                    guard context.offset.y > 0 || context.offset.x > 0 else {
                                        newHeight = oldHeight
                                        newWidth = oldWidth
                                        return
                                    }
                                    let defaultAxis = resize.size == .height ? ScrollAxis.vertical: .horizontal
                                    let newValue = resize.size == .height ? newHeight: newWidth
                                    let value = context.offset.getValue(resize.axis ?? defaultAxis) * (resize.speed ?? 100)/100
                                    //MARK: - Resize Conditions
                                    guard let oldHeight else {return}
                                    if let direction = resize.direction {
                                        guard context.direction == direction else {return}
                                    }
                                    if let minValue = resize.minValue {
                                        guard newValue ?? 0 > minValue else {return}
                                    }
                                    if let minOffset = resize.minOffset {
                                        guard value > minOffset else {return}
                                    }
                                    //MARK: - Resize Logic
                                    let negativeToAssign = oldHeight - value
                                    let positiveToAssign = oldHeight + value
                                    if let anchor = resize.anchor {
                                        guard let anchorView = context.anchors.first(where: {$0.anchor == anchor}), let point = resize.point, let pointPosition = anchorView.reader?.frame(in: .scrollView).getValue(resize.position ?? .max, axis: resize.axis ?? defaultAxis) else {return}
                                        let target = point.getValue(resize.axis ?? defaultAxis)
                                        if pointPosition < 0 {
                                            setNewValue(resize.value, size: resize.size)
                                        }else if pointPosition > target + resize.value {
                                            setNewValue(0, size: resize.size)
                                        }else if pointPosition < target + resize.value {
                                            setNewValue(resize.value - pointPosition, size: resize.size)
                                        }
                                    }else {
                                        if negativeToAssign > resize.value  {
                                            setNewValue(negativeToAssign, size: resize.size)
                                        }else if positiveToAssign < resize.value {
                                            setNewValue(positiveToAssign, size: resize.size)
                                        }
                                    }
                                }
                        }
                    }
                }.frame(width: newWidth, height: newHeight, alignment: alignment ?? .center)
                .padding(padding.0, padding.1)
                .offset(x: offsetValue.0, y: offsetValue.1)
                .opacity(newHeight == 0 ? 0: 1)
        }
    }
}
