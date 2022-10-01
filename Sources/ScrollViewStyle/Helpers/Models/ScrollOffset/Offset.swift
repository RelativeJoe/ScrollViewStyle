//
//  File.swift
//
//
//  Created by Joe Maghzal on 9/17/22.
//

import STools
import SwiftUI

public struct Offset: ScrollOffset {
    public var edge: ScrollAxis
    public var maxValue: CGFloat?
    public var speed: CGFloat?
    public var minOffset: CGFloat?
    public var minValue: CGFloat?
    public var direction: ScrollDirection?
    public var axis: ScrollAxis?
    public var animation: Animation?
    public var anchor: String?
    public var position: PointPosition?
    public var invertedOffset: Bool
    public var differential: Bool
    public var type: OffsetType {
        return .offset(self)
    }
    public func initialize(maxValue: CGFloat?, speed: CGFloat?, minOffset: CGFloat?, minValue: CGFloat?, direction: ScrollDirection?, axis: ScrollAxis?, animation: Animation?, differential: Bool?) -> Offset {
        return Offset(edge: edge, maxValue: maxValue ?? self.maxValue, speed: speed ?? self.speed, minOffset: minOffset ?? self.minOffset, minValue: minValue ?? self.minValue, direction: direction ?? self.direction, axis: axis ?? self.axis, animation: animation ?? self.animation, anchor: anchor, position: position, invertedOffset: invertedOffset, differential: differential ?? self.differential)
    }
}

//MARK: - Public Initializer
public extension Offset {
    init(for edge: ScrollAxis) {
        self.edge = edge
        self.invertedOffset = false
        self.differential = false
    }
}

//MARK: - Public Functions
public extension Offset {
    func inverted() -> Offset {
        return Offset(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, anchor: anchor, position: position, invertedOffset: true, differential: differential)
    }
    func relative(to anchor: CustomStringConvertible, at position: PointPosition) -> Offset {
        return Offset(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, anchor: anchor.description, position: position, invertedOffset: invertedOffset, differential: differential)
    }
}
