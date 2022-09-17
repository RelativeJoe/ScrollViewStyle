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

//MARK: - Public Functions
public extension Padding {
    func with(speed: CGFloat) -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation)
    }
    func with(animation: Animation) -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation)
    }
    func minimumOffset(_ minOffset: CGFloat) -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation)
    }
    func minimum(value: CGFloat) -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: value, direction: direction, axis: axis, animation: animation)
    }
    func maximum(value: CGFloat) -> Padding {
        return Padding(edge: edge, maxValue: value, speed: speed, minOffset: minOffset, minValue: value, direction: direction, axis: axis, animation: animation)
    }
    func on(axis: ScrollAxis) -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation)
    }
    func when(direction: ScrollDirection) -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation)
    }
}
