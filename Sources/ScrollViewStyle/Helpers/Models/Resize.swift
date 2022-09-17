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
    internal var direction: ScrollDirection?
    internal var anchor: String?
    internal var point: CGPoint?
    internal var axis: ScrollAxis?
    internal var position: PointPosition?
    public var type: OffsetType {
        return .resize(self)
    }
}

//MARK: - Public Initializer
public extension Resize {
    init(for change: SizeChange, to value: CGFloat) {
        self.size = change
        self.value = value
    }
}

//MARK: - Public Functions
public extension Resize {
    func with(speed: CGFloat) -> Resize {
        return Resize(size: size, value: value, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, anchor: anchor, point: point, axis: axis, position: position)
    }
    func minimumOffset(_ minOffset: CGFloat) -> Resize {
        return Resize(size: size, value: value, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, anchor: anchor, point: point, axis: axis, position: position)
    }
    func minimumValue(_ minValue: CGFloat) -> Resize {
        return Resize(size: size, value: value, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, anchor: anchor, point: point, axis: axis, position: position)
    }
    func on(axis: ScrollAxis) -> Resize {
        return Resize(size: size, value: value, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, anchor: anchor, point: point, axis: axis, position: position)
    }
    func when(direction: ScrollDirection) -> Resize {
        return Resize(size: size, value: value, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, anchor: anchor, point: point, axis: axis, position: position)
    }
    func relative(to anchor: CustomStringConvertible, startPoint: CGPoint, at position: PointPosition) -> Resize {
        return Resize(size: size, value: value, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, anchor: anchor.description, point: startPoint, axis: axis, position: position)
    }
}

