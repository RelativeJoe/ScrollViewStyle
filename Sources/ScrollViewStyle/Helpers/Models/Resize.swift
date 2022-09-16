//
//  File.swift
//  
//
//  Created by Joe Maghzal on 9/16/22.
//

import STools
import SwiftUI

public struct Resize: ScrollOffset {
    internal var size: SizeChange
    internal var value: CGFloat
    internal var speed: CGFloat?
    internal var minOffset: CGFloat?
    internal var minValue: CGFloat?
    internal var direction: ScrollDirection
    internal var anchor: String?
    internal var point: CGPoint?
    public var type: OffsetType {
        switch size {
            case .height:
                return .heightResize(height: value, speed: speed, minOffset: minOffset, minHeight: minValue, vertical: direction == .top || direction == .bottom, anchor: anchor, point: point)
            case .width:
                return .widthResize(width: value, speed: speed, minOffset: minOffset, minWidth: minValue, vertical: direction == .top || direction == .bottom)
        }
    }
}

//MARK: - Public Initializer
public extension Resize {
    init(size: SizeChange, to value: CGFloat) {
        self.size = size
        self.value = value
        self.direction = .top
    }
}

//MARK: - Internal Initializer
internal extension Resize {
    init(size: SizeChange, value: CGFloat, speed: CGFloat?, minOffset: CGFloat?, minHeight: CGFloat?, direction: ScrollDirection, anchor: String?, point: CGPoint?) {
        self.size = size
        self.value = value
        self.speed = speed
        self.minOffset = minOffset
        self.minValue = minHeight
        self.direction = direction
        self.anchor = anchor
        self.point = point
    }
}

//MARK: - Public Functions
public extension Resize {
    func with(speed: CGFloat) -> Resize {
        return Resize(size: size, value: value, speed: speed, minOffset: minOffset, minHeight: minValue, direction: direction, anchor: anchor, point: point)
    }
    func minimumOffset(_ minOffset: CGFloat) -> Resize {
        return Resize(size: size, value: value, speed: speed, minOffset: minOffset, minHeight: minValue, direction: direction, anchor: anchor, point: point)
    }
    func minimumValue(_ minValue: CGFloat) -> Resize {
        return Resize(size: size, value: value, speed: speed, minOffset: minOffset, minHeight: minValue, direction: direction, anchor: anchor, point: point)
    }
    func when(direction: ScrollDirection) -> Resize {
        return Resize(size: size, value: value, speed: speed, minOffset: minOffset, minHeight: minValue, direction: direction, anchor: anchor, point: point)
    }
    func relative(to anchor: CustomStringConvertible, startPoint: CGPoint) -> Resize {
        return Resize(size: size, value: value, speed: speed, minOffset: minOffset, minHeight: minValue, direction: direction, anchor: anchor.description, point: startPoint)
    }
}

public protocol ScrollOffset {
    var type: OffsetType {get}
}
