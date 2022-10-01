//
//  File.swift
//
//
//  Created by Joe Maghzal on 9/17/22.
//

import STools
import SwiftUI

public struct Offset: ScrollOffset {
    internal var edge: ScrollAxis
    internal var maxValue: CGFloat?
    internal var speed: CGFloat?
    internal var minOffset: CGFloat?
    internal var minValue: CGFloat?
    internal var direction: ScrollDirection?
    internal var axis: ScrollAxis?
    internal var animation: Animation?
    internal var anchor: String?
    internal var position: PointPosition?
    internal var invertedOffset: Bool
    public var type: OffsetType {
        return .offset(self)
    }
}

//MARK: - Public Initializer
public extension Offset {
    init(for edge: ScrollAxis) {
        self.edge = edge
        self.invertedOffset = false
    }
}

//MARK: - Public Functions
public extension Offset {
    func inverted() -> Offset {
        return Offset(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, anchor: anchor, position: position, invertedOffset: true)
    }
    func with(speed: CGFloat) -> Offset {
        return Offset(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, anchor: anchor, position: position, invertedOffset: invertedOffset)
    }
    func with(animation: Animation) -> Offset {
        return Offset(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, anchor: anchor, position: position, invertedOffset: invertedOffset)
    }
    func minimumOffset(_ minOffset: CGFloat) -> Offset {
        return Offset(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, anchor: anchor, position: position, invertedOffset: invertedOffset)
    }
    func minimum(value: CGFloat) -> Offset {
        return Offset(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: value, direction: direction, axis: axis, animation: animation, anchor: anchor, position: position, invertedOffset: invertedOffset)
    }
    func maximum(value: CGFloat) -> Offset {
        return Offset(edge: edge, maxValue: value, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, anchor: anchor, position: position, invertedOffset: invertedOffset)
    }
    func on(axis: ScrollAxis) -> Offset {
        return Offset(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, anchor: anchor, position: position, invertedOffset: invertedOffset)
    }
    func when(direction: ScrollDirection) -> Offset {
        return Offset(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, anchor: anchor, position: position, invertedOffset: invertedOffset)
    }
    func relative(to anchor: CustomStringConvertible, at position: PointPosition) -> Offset {
        return Offset(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, anchor: anchor.description, position: position, invertedOffset: invertedOffset)
    }
}
