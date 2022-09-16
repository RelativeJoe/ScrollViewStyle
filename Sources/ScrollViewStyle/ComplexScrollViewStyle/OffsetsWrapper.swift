//
//  File.swift
//  
//
//  Created by Joe Maghzal on 9/12/22.
//

import SwiftUI
import STools

public struct OffsetsWrapper<Content: View>: View {
    @State var offsets = [OffsetType]()
    var content: Content
    @State  var width: CGFloat?
    @State var height: CGFloat?
    var alignment: Alignment?
//    internal init(content: Content, width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment? = nil) {
//        self.content = content
//        self._width = State(wrappedValue: width)
//        self._height = State(wrappedValue: height)
//        self.alignment = alignment
//    }
    public var body: some View {
        content
            .onChange(of: .height) { heighty in
                guard height == nil, height == 0 else {return}
                height = heighty
            }.onChange(of: .width) { widthy in
                guard height == nil, width == 0 else {return}
                width = widthy
            }.modifier(OffsetViewModifier(offsets: offsets, oldHeight: height, oldWidth: width, alignment: alignment))
    }
    public func onScroll(offset: OffsetType) -> OffsetsWrapper {
        var offsetsy = offsets
        offsetsy.append(offset)
        return OffsetsWrapper(offsets: offsetsy, content: content, width: width, height: height, alignment: alignment)
    }
}

public extension View {
    @ViewBuilder func scrollFrame(width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment? = nil) -> OffsetsWrapper<Self> {
        OffsetsWrapper(content: self, width: width, height: height, alignment: alignment)
    }
}
