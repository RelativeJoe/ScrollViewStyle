//
//  Extensions.swift
//  
//
//  Created by Joe Maghzal on 9/16/22.
//

import SwiftUI

extension CGSize {
    func value(for axis: Axis) -> CGFloat {
        return axis == .vertical ? height: width
    }
}

extension Axis {
    var axisSet: Axis.Set {
        return self == .vertical ? .vertical: .horizontal
    }
}
