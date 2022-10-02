//
//  File.swift
//  
//
//  Created by Joe Maghzal on 9/16/22.
//

import STools
import SwiftUI

public struct Resize: ScrollOffset {
    public var size: SizeChange
    public var value: CGFloat
    public var speed: CGFloat?
    public var minOffset: CGFloat?
    public var minValue: CGFloat?
    public var maxValue: CGFloat?
    public var direction: ScrollDirection?
    public var anchor: String?
    public var point: CGPoint?
    public var axis: ScrollAxis?
    public var position: PointPosition?
    public var animation: Animation?
    public var differential: Bool
    public var differentialDirection: ScrollDirection?
    public var type: OffsetType {
        return .resize(self)
    }
    public func initialize(maxValue: CGFloat?, speed: CGFloat?, minOffset: CGFloat?, minValue: CGFloat?, direction: ScrollDirection?, axis: ScrollAxis?, animation: Animation?, differential: Bool?, differentialDirection: ScrollDirection?) -> Resize {
        return Resize(size: size, value: value, speed: speed ?? self.speed, minOffset: minOffset ?? self.minOffset, minValue: minValue ?? self.minValue, maxValue: minValue ?? self.maxValue, direction: direction ?? self.direction, anchor: anchor, point: point, axis: axis ?? self.axis, position: position, animation: animation ?? self.animation, differential: differential ?? self.differential, differentialDirection: differentialDirection ?? self.differentialDirection)
    }
}

//MARK: - Public Initializer
public extension Resize {
    init(for change: SizeChange, to value: CGFloat) {
        self.size = change
        self.value = value
        self.differential = false
    }
}

//MARK: - Public Functions
public extension Resize {
    func relative(to anchor: CustomStringConvertible, startPoint: CGPoint, at position: PointPosition) -> Resize {
        return Resize(size: size, value: value, speed: speed, minOffset: minOffset, minValue: minValue, maxValue: maxValue, direction: direction, anchor: anchor.description, point: startPoint, axis: axis, position: position, animation: animation, differential: differential, differentialDirection: differentialDirection)
    }
}
