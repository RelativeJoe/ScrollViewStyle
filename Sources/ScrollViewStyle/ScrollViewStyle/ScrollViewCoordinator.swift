//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//

import SwiftUI

open class ScrollViewCoordinator: NSObject, Delegate {
    @Published public var offset = CGPoint.zero
    @Published public var isDragging = Dragging.iddle
    @Published public var direction: ScrollDirection?
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var temporaryDirection = [ScrollDirection]()
        if self.offset.y > scrollView.contentOffset.y {
            temporaryDirection.append(.top)
        }else if self.offset.y < scrollView.contentOffset.y {
            temporaryDirection.append(.bottom)
        }
        if self.offset.x > scrollView.contentOffset.x {
            if temporaryDirection.isEmpty {
                direction = .leading
            }else {
                temporaryDirection.append(.leading)
//                direction = temporaryDirection
            }
        }else if self.offset.x < scrollView.contentOffset.x {
            if temporaryDirection.isEmpty {
                direction = .trailing
            }else {
                temporaryDirection.append(.trailing)
//                direction = temporaryDirection
            }
        }
        self.offset = scrollView.contentOffset
    }
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDragging = .initiated
    }
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        isDragging = .userEnded
    }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isDragging = .iddle
    }
}

public protocol Delegate: AnyObject, ObservableObject, UIScrollViewDelegate {
    var offset: CGPoint {get set}
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}
