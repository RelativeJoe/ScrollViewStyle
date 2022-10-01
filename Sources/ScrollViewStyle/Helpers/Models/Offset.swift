//
//  File.swift
//
//
//  Created by Joe Maghzal on 9/17/22.
//

import STools
import SwiftUI

public struct Offset: ScrollOffset {
    internal var edge: OffsetEdge
    internal var maxValue: CGFloat?
    internal var speed: CGFloat?
    internal var minOffset: CGFloat?
    internal var minValue: CGFloat?
    internal var direction: ScrollDirection?
    internal var axis: ScrollAxis?
    internal var animation: Animation?
    internal var anchor: String?
    internal var point: CGPoint?
    internal var position: PointPosition?
    internal var invertedOffset: Bool
    public var type: OffsetType {
        return .offset(self)
    }
}

//MARK: - Public Initializer
public extension Offset {
    init(for edge: OffsetEdge) {
        self.edge = edge
        self.invertedOffset = false
    }
}

//MARK: - Public Functions
public extension Offset {
    func inverted() -> Offset {
        return Offset(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, anchor: anchor, point: point, position: position, invertedOffset: true)
    }
    func with(speed: CGFloat) -> Offset {
        return Offset(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, anchor: anchor, point: point, position: position, invertedOffset: invertedOffset)
    }
    func with(animation: Animation) -> Offset {
        return Offset(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, anchor: anchor, point: point, position: position, invertedOffset: invertedOffset)
    }
    func minimumOffset(_ minOffset: CGFloat) -> Offset {
        return Offset(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, anchor: anchor, point: point, position: position, invertedOffset: invertedOffset)
    }
    func minimum(value: CGFloat) -> Offset {
        return Offset(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: value, direction: direction, axis: axis, animation: animation, anchor: anchor, point: point, position: position, invertedOffset: invertedOffset)
    }
    func maximum(value: CGFloat) -> Offset {
        return Offset(edge: edge, maxValue: value, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, anchor: anchor, point: point, position: position, invertedOffset: invertedOffset)
    }
    func on(axis: ScrollAxis) -> Offset {
        return Offset(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, anchor: anchor, point: point, position: position, invertedOffset: invertedOffset)
    }
    func when(direction: ScrollDirection) -> Offset {
        return Offset(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, anchor: anchor, point: point, position: position, invertedOffset: invertedOffset)
    }
    func relative(to anchor: CustomStringConvertible, point: CGPoint, at position: PointPosition) -> Offset {
        return Offset(edge: edge, maxValue: maxValue, speed: speed, minOffset: minOffset, minValue: minValue, direction: direction, axis: axis, animation: animation, anchor: anchor.description, point: point, position: position, invertedOffset: invertedOffset)
    }
}

public enum OffsetEdge: OptionSet {
    public var rawValue: Int {
        switch self {
            case .vertical:
                return 0
            case .horizontal:
                return 1
        }
    }
    public init(rawValue: Int) {
        self = rawValue == 0 ? .vertical: .horizontal
    }
    case vertical, horizontal
}
