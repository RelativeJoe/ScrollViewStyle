//
//  File.swift
//  
//
//  Created by Joe Maghzal on 9/17/22.
//

import Foundation
import SwiftUI

public protocol ScrollOffset {
    var maxValue: CGFloat? {get set}
    var speed: CGFloat? {get set}
    var minOffset: CGFloat? {get set}
    var minValue: CGFloat? {get set}
    var direction: ScrollDirection? {get set}
    var axis: ScrollAxis? {get set}
    var animation: Animation? {get set}
    var differential: Bool {get set}
    var type: OffsetType {get}
    func initialize(maxValue: CGFloat?, speed: CGFloat?, minOffset: CGFloat?, minValue: CGFloat?, direction: ScrollDirection?, axis: ScrollAxis?, animation: Animation?, differential: Bool?) -> Self
}

public extension ScrollOffset {
    func with(speed: CGFloat) -> Self {
        return initialize(maxValue: nil, speed: speed, minOffset: nil, minValue: nil, direction: nil, axis: nil, animation: nil, differential: nil)
    }
    func with(animation: Animation) -> Self {
        return initialize(maxValue: nil, speed: nil, minOffset: nil, minValue: nil, direction: nil, axis: nil, animation: animation, differential: nil)
    }
    func minimumOffset(_ minOffset: CGFloat) -> Self {
        return initialize(maxValue: nil, speed: nil, minOffset: minOffset, minValue: nil, direction: nil, axis: nil, animation: nil, differential: nil)
    }
    func minimum(value: CGFloat) -> Self {
        return initialize(maxValue: nil, speed: nil, minOffset: nil, minValue: value, direction: nil, axis: nil, animation: nil, differential: nil)
    }
    func maximum(value: CGFloat) -> Self {
        return initialize(maxValue: value, speed: nil, minOffset: nil, minValue: nil, direction: nil, axis: nil, animation: nil, differential: nil)
    }
    func on(axis: ScrollAxis) -> Self {
        return initialize(maxValue: nil, speed: nil, minOffset: nil, minValue: nil, direction: nil, axis: axis, animation: nil, differential: nil)
    }
    func when(direction: ScrollDirection) -> Self {
        return initialize(maxValue: nil, speed: nil, minOffset: nil, minValue: nil, direction: direction, axis: nil, animation: nil, differential: true)
    }
    func differtial() -> Self {
        return initialize(maxValue: nil, speed: nil, minOffset: nil, minValue: nil, direction: nil, axis: nil, animation: nil, differential: true)
    }
}
