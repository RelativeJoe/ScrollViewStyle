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

@available(iOS 13.0, *)
extension GeometryProxy: Equatable {
    public static func ==(lhs: GeometryProxy, rhs: GeometryProxy) -> Bool {
        return lhs.size == rhs.size || lhs.safeAreaInsets == rhs.safeAreaInsets || lhs.frame(in: .global) == rhs.frame(in: .global) || lhs.frame(in: .scrollView) == rhs.frame(in: .scrollView)
    }
}

public extension CoordinateSpace {
    static let scrollView = Self.named("ScrollView")
}
