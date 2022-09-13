//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//

import SwiftUI

open class ScrollViewCoordinator: NSObject, Delegate {
    @Published public var offset: CGFloat = 0
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.offset = scrollView.contentOffset.y
    }
}

public protocol Delegate: AnyObject, ObservableObject, UIScrollViewDelegate {
    var offset: CGFloat {get set}
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}
