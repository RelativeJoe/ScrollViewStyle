//
//  File.swift
//  
//
//  Created by Joe Maghzal on 9/16/22.
//

import Foundation
import SwiftUI

internal extension CGPoint {
    func getValue(_ vertical: Bool) -> CGFloat {
        if vertical {
            return y
        }
        return x
    }
}

public extension CoordinateSpace {
    static let scrollView = Self.named("ScrollView")
}
