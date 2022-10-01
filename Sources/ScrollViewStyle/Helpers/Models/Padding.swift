//
//  File.swift
//  
//
//  Created by Joe Maghzal on 9/17/22.
//

import STools
import SwiftUI

public struct Padding: ScrollOffset {
    internal var edge: Edge.Set
    internal var maxValue: CGFloat?
    internal var speed: CGFloat?
    internal var minOffset: CGFloat?
    internal var minValue: CGFloat?
    internal var direction: ScrollDirection?
    internal var axis: ScrollAxis?
    internal var animation: Animation?
    internal var invertedOffset: Bool
    internal var anchor: String?
    internal var position: PointPosition?
    internal var condition: Bool
    public var type: OffsetType {
        return .padding(self)
    }
}

//MARK: - Public Initializer
public extension Padding {
    init(for edge: Edge.Set) {
        self.edge = edge
        self.invertedOffset = false
        self.condition = true
    }
}

//MARK: - Public Functions
public extension Padding {
    func inverted() -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, invertedOffset: true, anchor: anchor, position: position, condition: condition)
    }
    func with(speed: CGFloat) -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, invertedOffset: invertedOffset, anchor: anchor, position: position, condition: condition)
    }
    func with(animation: Animation) -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, invertedOffset: invertedOffset, anchor: anchor, position: position, condition: condition)
    }
    func minimumOffset(_ minOffset: CGFloat) -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, invertedOffset: invertedOffset, anchor: anchor, position: position, condition: condition)
    }
    func minimum(value: CGFloat) -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: value, direction: direction, axis: axis, animation: animation, invertedOffset: invertedOffset, anchor: anchor, position: position, condition: condition)
    }
    func maximum(value: CGFloat) -> Padding {
        return Padding(edge: edge, maxValue: value, speed: speed, minOffset: minOffset, minValue: value, direction: direction, axis: axis, animation: animation, invertedOffset: invertedOffset, anchor: anchor, position: position, condition: condition)
    }
    func on(axis: ScrollAxis) -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, invertedOffset: invertedOffset, anchor: anchor, position: position, condition: condition)
    }
    func when(direction: ScrollDirection) -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, invertedOffset: invertedOffset, anchor: anchor, position: position, condition: condition)
    }
    func relative(to anchor: CustomStringConvertible, at position: PointPosition) -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, invertedOffset: invertedOffset, anchor: anchor.description, position: position, condition: condition)
    }
    func when(_ condition: Bool) -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, invertedOffset: invertedOffset, anchor: anchor, position: position, condition: condition)
    }
}
