//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//

import SwiftUI

public class ScrollViewCoordinator: NSObject, UIScrollViewDelegate, ObservableObject {
    @Published public var offset: CGFloat = 0
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.offset = scrollView.contentOffset.y
    }
}
