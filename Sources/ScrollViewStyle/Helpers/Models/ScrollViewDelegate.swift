//
//  File.swift
//  
//
//  Created by Joe Maghzal on 9/17/22.
//

import SwiftUI

public protocol ScrollViewDelegate: AnyObject, ObservableObject, UIScrollViewDelegate {
    var offset: CGPoint {get set}
    var differentialOffset: CGPoint {get set}
    var state: Dragging {get set}
    var direction: ScrollDirection? {get set}
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}
