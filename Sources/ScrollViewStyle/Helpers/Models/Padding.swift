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
    public var type: OffsetType {
        return .padding(self)
    }
}

//MARK: - Public Initializer
public extension Padding {
    init(for edge: Edge.Set) {
        self.edge = edge
    }
}

//MARK: - Internal Initializer
internal extension Padding {
    init(edge: Edge.Set, maxValue: CGFloat?, speed: CGFloat?, minOffset: CGFloat?, minValue: CGFloat?, direction: ScrollDirection, axis: ScrollAxis?) {
        self.edge = edge
        self.maxValue = maxValue
        self.speed = speed
        self.minOffset = minOffset
        self.minValue = minValue
        self.direction = direction
        self.axis = axis
    }
}

//MARK: - Public Functions
public extension Padding {
    func with(speed: CGFloat) -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis)
    }
    func minimumOffset(_ minOffset: CGFloat) -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis)
    }
    func minimum(value: CGFloat) -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: value, direction: direction, axis: axis)
    }
    func maximum(value: CGFloat) -> Padding {
        return Padding(edge: edge, maxValue: value, speed: speed, minOffset: minOffset, minValue: value, direction: direction, axis: axis)
    }
    func on(axis: ScrollAxis) -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis)
    }
    func when(direction: ScrollDirection) -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis)
    }
}
