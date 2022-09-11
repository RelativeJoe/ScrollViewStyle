//
//  File.swift
//  
//
//  Created by Joe Maghzal on 9/11/22.
//

import SwiftUI

struct OffsetViewModifier: ViewModifier {
    let offset: OffsetType
    let oldHeight: CGFloat
    @State var newHeight: CGFloat = 0
    @State var padding: (Edge, CGFloat) = (.top, 0)
    @Environment(\.prefrenceContext) var context
    init(offset: OffsetType, oldHeight: CGFloat) {
        self.offset = offset
        self.oldHeight = oldHeight
        self._newHeight = State(wrappedValue: oldHeight)
    }
    func body(content: Content) -> some View {
        content
            .onChange(of: context) { value in
                guard let context = value else {
                    return
                }
                switch offset {
                    case .padding(let edge, let maxValue, let speed):
                        padding.0 = edge
                        let newPadding = context.offset * (speed ?? 100)/100
                        if let maxValue {
                            guard newPadding < maxValue else {return}
                        }
                        padding.1 = newPadding
                    case .resize(let height, let speed):
                        let negativeToAssign = oldHeight - context.offset * (speed ?? 100)/100
                        let positiveToAssign = oldHeight + context.offset * (speed ?? 100)/100
                        if negativeToAssign > height  {
                            newHeight = negativeToAssign
                        }else if positiveToAssign < height {
                            newHeight = positiveToAssign
                        }
                }
            }
            .frame(height: newHeight)
    }
}

public extension View {
    @ViewBuilder func onScroll(offset: OffsetType, height: CGFloat) -> some View {
        self
            .modifier(OffsetViewModifier(offset: offset, oldHeight: height))
    }
}
