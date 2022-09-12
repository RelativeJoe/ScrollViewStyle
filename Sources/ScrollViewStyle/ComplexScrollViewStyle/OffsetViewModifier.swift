//
//  File.swift
//  
//
//  Created by Joe Maghzal on 9/11/22.
//

import SwiftUI
import STools

internal struct OffsetViewModifier: ViewModifier {
    private let offsets: [OffsetType]
    private let oldHeight: CGFloat?
    private let oldWidth: CGFloat?
    private let alignment: Alignment?
    @State private var newHeight: CGFloat?
    @State private var newWidth: CGFloat?
    @State private var padding: (Edge.Set, CGFloat) = (.top, 0)
    @Environment(\.prefrenceContext) private var context
    internal init(offsets: [OffsetType], oldHeight: CGFloat?, oldWidth: CGFloat?, alignment: Alignment?) {
        self.offsets = offsets
        self.oldHeight = oldHeight
        self.oldWidth = oldWidth
        self.alignment = alignment
        self._newHeight = State(wrappedValue: oldHeight)
        self._newWidth = State(wrappedValue: oldWidth)
    }
    internal func body(content: Content) -> some View {
        content
            .onChange(of: context) { value in
                guard let context = value else {
                    return
                }
                offsets.forEach { offset in
                    switch offset {
                        case .padding(let edge, let maxValue, let speed):
                            padding.0 = edge
                            let newPadding = context.offset * (speed ?? 100)/100
                            if let maxValue {
                                guard newPadding < maxValue else {return}
                            }
                            padding.1 = newPadding
                        case .heightResize(let height, let speed, let minOffset, let minHeight):
                            guard let oldHeight else {return}
                            if let minHeight {
                                guard newHeight ?? 0 > minHeight else {return}
                            }
                            if let minOffset {
                                guard context.offset > minOffset else {return}
                            }
                            let negativeToAssign = oldHeight - context.offset * (speed ?? 100)/100
                            let positiveToAssign = oldHeight + context.offset * (speed ?? 100)/100
                            if negativeToAssign > height  {
                                newHeight = negativeToAssign
                            }else if positiveToAssign < height {
                                newHeight = positiveToAssign
                            }
                        case .widthResize(let width, let speed, let minOffset, let minWidth):
                            guard let oldWidth else {return}
                            if let minWidth {
                                guard newWidth ?? 0 > minWidth else {return}
                            }
                            if let minOffset {
                                guard context.offset > minOffset else {return}
                            }
                            let negativeToAssign = oldWidth - context.offset * (speed ?? 100)/100
                            let positiveToAssign = oldWidth + context.offset * (speed ?? 100)/100
                            if negativeToAssign > width  {
                                newWidth = negativeToAssign
                            }else if positiveToAssign < width {
                                newWidth = positiveToAssign
                            }
                    }
                }
            }.stateModifier(oldHeight != nil) { view in
                view
                    .frame(width: newWidth, height: newHeight, alignment: alignment ?? .center)
            }.padding(padding.0, padding.1)
    }
}
