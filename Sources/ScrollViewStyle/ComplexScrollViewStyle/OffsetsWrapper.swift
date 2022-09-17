//
//  File.swift
//  
//
//  Created by Joe Maghzal on 9/12/22.
//

import SwiftUI
import STools

public struct OffsetsWrapper<Content: View>: View {
    @State internal var offsets = [OffsetType]()
    internal var content: Content
    @State internal var width: CGFloat?
    @State internal var height: CGFloat?
    @State private var newHeightSet = false
    @State private var newWidthSet = false
    @Binding internal var context: Context?
    internal var alignment: Alignment?
    public var body: some View {
        content
            .onChange(of: .height) { heighty in
                guard height == nil, !newHeightSet else {return}
                height = heighty
                newHeightSet = true
            }.onChange(of: .width) { widthy in
                guard width == nil, !newWidthSet else {return}
                width = widthy
                newWidthSet = true
            }.modifier(OffsetViewModifier(offsets: offsets, oldHeight: height, oldWidth: width, alignment: alignment, context: $context))
    }
    public func onScroll(offset: OffsetType) -> OffsetsWrapper {
        var offsetsy = offsets
        offsetsy.append(offset)
        return OffsetsWrapper(offsets: offsetsy, content: content, width: width, height: height, context: $context, alignment: alignment)
    }
    public func onScroll<Offset: ScrollOffset>(_ offset: Offset) -> OffsetsWrapper {
        var offsetsy = offsets
        offsetsy.append(offset.type)
        return OffsetsWrapper(offsets: offsetsy, content: content, width: width, height: height, context: $context, alignment: alignment)
    }
    public func onScroll<Offset: ScrollOffset>(_ offset: @escaping () -> Offset) -> OffsetsWrapper {
        var offsetsy = offsets
        offsetsy.append(offset().type)
        return OffsetsWrapper(offsets: offsetsy, content: content, width: width, height: height, context: $context, alignment: alignment)
    }
}

public extension View {
    @ViewBuilder func scrollFrame(width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment? = nil, context: Binding<Context?>) -> OffsetsWrapper<Self> {
        OffsetsWrapper(content: self, width: width, height: height, context: context, alignment: alignment)
    }
}
