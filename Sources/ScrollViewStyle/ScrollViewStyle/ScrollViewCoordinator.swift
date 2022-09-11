//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//

import SwiftUI

public final class ScrollViewCoordinator: NSObject, UIScrollViewDelegate, ObservableObject {
    @Published var offset: CGFloat = 0
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.offset = scrollView.contentOffset.y
    }
}
