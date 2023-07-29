//
//  ExtendedScrollViewStyle.swift
//  
//
//  Created by Joe Maghzal on 29/07/2023.
//

import SwiftUI

public struct ExtendedScrollViewStyle {
//MARK: - Properties
    @Binding private var context: ScrollContext
//MARK: - Initializers
    public init(context: Binding<ScrollContext>) {
        self._context = context
    }
}

//MARK: - ScrollViewStyle
extension ExtendedScrollViewStyle: ScrollViewStyle {
    public func makeCoordinator() -> ExtendedScrollCoordinator {
        return ExtendedScrollCoordinator(context: $context)
    }
}

public class ExtendedScrollCoordinator: NSObject, ObservableObject {
//MARK: - Properties
    @Binding var context: ScrollContext
//MARK: - Initializers
    init(context: Binding<ScrollContext>) {
        self._context = context
    }
}

//MARK: - UIScrollViewDelegate
extension ExtendedScrollCoordinator: UIScrollViewDelegate {
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
