//
//  ScrollContext.swift
//  
//
//  Created by Joe Maghzal on 29/07/2023.
//

import Foundation

public struct ScrollContext {
    public var scrolling = false
    public var offset = CGPoint.zero
    public var dragging: ScrollDragingState?
}

public enum ScrollDragingState {
    case started, ending(velocity: CGPoint, targetOffset: UnsafeMutablePointer<CGPoint>), ended(decelerating: Bool)
}
