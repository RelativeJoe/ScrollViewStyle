//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//

import SwiftUI

@available(iOS 13.0, *)
class ScrollViewCoordinator: NSObject, UIScrollViewDelegate, ObservableObject {
    @Published var offset: CGFloat = 0
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.offset = scrollView.contentOffset.y
    }
}
