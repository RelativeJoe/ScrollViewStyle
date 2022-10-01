//
//  File.swift
//  
//
//  Created by Joe Maghzal on 9/16/22.
//

import Foundation
import SwiftUI

internal extension CGPoint {
    func getValue(_ axis: ScrollAxis) -> CGFloat {
        return axis == .vertical ? y: x
    }
    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    static func -(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
}

extension CGPoint: Comparable {
    public static func < (lhs: CGPoint, rhs: CGPoint) -> Bool {
        lhs.x < rhs.x || lhs.y < rhs.y
    }
}

internal extension CGRect {
    func getValue(_ position: PointPosition, axis: ScrollAxis) -> CGFloat {
        switch position {
            case .min:
                return axis == .vertical ? minY: minX
            case .mid:
                return axis == .vertical ? midY: midX
            case .max:
                return axis == .vertical ? maxY: maxX
        }
    }
}

extension GeometryProxy: Equatable {
    public static func ==(lhs: GeometryProxy, rhs: GeometryProxy) -> Bool {
        return lhs.size == rhs.size && lhs.frame(in: .global).maxY == rhs.frame(in: .global).maxY && lhs.frame(in: .global).minY == rhs.frame(in: .global).minY && lhs.frame(in: .global).maxX == rhs.frame(in: .global).maxX && lhs.frame(in: .global).minX == rhs.frame(in: .global).minX
    }
}

public extension CoordinateSpace {
    static let scrollView = Self.named("ScrollView")
}
