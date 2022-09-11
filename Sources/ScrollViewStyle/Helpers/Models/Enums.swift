//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//

import SwiftUI

public enum ScrollDirection {
    case up, down
}

public enum OffsetType {
    case padding(edge: Edge.Set, maxValue: CGFloat? = nil, speed: CGFloat? = nil)
    case resize(height: CGFloat, speed: CGFloat? = nil, minOffset: CGFloat? = nil, minHeight: CGFloat? = nil)
}
