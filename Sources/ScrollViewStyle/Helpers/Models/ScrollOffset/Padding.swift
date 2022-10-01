//
//  File.swift
//  
//
//  Created by Joe Maghzal on 9/17/22.
//

import STools
import SwiftUI

public struct Padding: ScrollOffset {
    public var edge: Edge.Set
    public var maxValue: CGFloat?
    public var speed: CGFloat?
    public var minOffset: CGFloat?
    public var minValue: CGFloat?
    public var direction: ScrollDirection?
    public var axis: ScrollAxis?
    public var animation: Animation?
    public var invertedOffset: Bool
    public var anchor: String?
    public var position: PointPosition?
    public var differential: Bool
    public var type: OffsetType {
        return .padding(self)
    }
    public func initialize(maxValue: CGFloat?, speed: CGFloat?, minOffset: CGFloat?, minValue: CGFloat?, direction: ScrollDirection?, axis: ScrollAxis?, animation: Animation?, differential: Bool?) -> Padding {
        return Padding(edge: edge, maxValue: minValue ?? self.maxValue, speed: speed ?? self.speed, minOffset: minOffset ?? self.minOffset, minValue: minValue ?? self.minValue, direction: direction ?? self.direction, axis: axis ?? self.axis, animation: animation ?? self.animation, invertedOffset: invertedOffset, anchor: anchor, position: position, differential: differential ?? self.differential)
    }
}

//MARK: - Public Initializer
public extension Padding {
    init(for edge: Edge.Set) {
        self.edge = edge
        self.invertedOffset = false
        self.differential = false
    }
}

//MARK: - Public Functions
public extension Padding {
    func inverted() -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, invertedOffset: true, anchor: anchor, position: position, differential: differential)
    }
    func relative(to anchor: CustomStringConvertible, at position: PointPosition) -> Padding {
        return Padding(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, invertedOffset: invertedOffset, anchor: anchor.description, position: position, differential: differential)
    }
}
