//
//  ScrollContext.swift
//  
//
//  Created by Joe Maghzal on 29/07/2023.
//

import Foundation

public struct ScrollContext {
    public var isScrolling = false
    public var offset = CGPoint.zero
    public var dragState: ScrollDragingState?
    public var isDragging: Bool {
        return dragState.isDragging
    }
}

public enum ScrollDragingState {
    case started, ending(velocity: CGPoint, targetOffset: UnsafeMutablePointer<CGPoint>), ended(decelerating: Bool)
}

public extension ScrollDragingState? {
    var isDragging: Bool {
        switch self {
            case .started, .ending:
                return true
            case .none, .ended:
                return false
        }
    }
}
