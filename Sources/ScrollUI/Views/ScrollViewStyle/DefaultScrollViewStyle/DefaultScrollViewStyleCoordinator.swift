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
        DispatchQueue.main.async {
            self.context.offset = scrollView.contentOffset
        }
    }
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        context.dragState = .started
        context.isScrolling = true
    }
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        context.dragState = .ending(velocity: velocity, targetOffset: targetContentOffset)
    }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        context.dragState = .ended(decelerating: decelerate)
        if !decelerate {
            context.isScrolling = false
        }
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        context.isScrolling = false
    }
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        context.isScrolling = false
        context.dragState = nil
    }
}
