//
//  DefaultScrollViewStyleCoordinator.swift
//
//
//  Created by Joe Maghzal on 31/12/2023.
//

import SwiftUI

public extension DefaultScrollViewStyle {
    class Coordinator: NSObject, ObservableObject {
//MARK: - Properties
        @Binding var context: ScrollContext
//MARK: - Initializers
        init(context: Binding<ScrollContext>) {
            self._context = context
        }
    }
}

//MARK: - UIScrollViewDelegate
extension DefaultScrollViewStyle.Coordinator: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        context.offset = scrollView.contentOffset
    }
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        context.dragging = .started
        context.scrolling = true
    }
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        context.dragging = .ending(velocity: velocity, targetOffset: targetContentOffset)
    }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        context.dragging = .ended(decelerating: decelerate)
        if !decelerate {
            context.scrolling = false
        }
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        context.scrolling = false
    }
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        context.scrolling = false
        context.dragging = nil
    }
}
