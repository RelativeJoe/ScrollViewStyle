//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//

import SwiftUI

open class ScrollViewCoordinator: NSObject, ScrollViewDelegate {
    @Published public var differentialOffset = CGPoint.zero
    @Published public var offset = CGPoint.zero
    @Published public var state = Dragging.iddle
    @Published public var direction: ScrollDirection?
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        DispatchQueue.main.async { [self] in
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
            if offset > scrollView.contentOffset {
                self.differentialOffset = offset - scrollView.contentOffset
            }else {
                self.differentialOffset = offset + scrollView.contentOffset
            }
            self.offset = scrollView.contentOffset
        }
    }
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        state = .initiated
    }
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        state = .userEnded
    }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        state = .iddle
    }
}

