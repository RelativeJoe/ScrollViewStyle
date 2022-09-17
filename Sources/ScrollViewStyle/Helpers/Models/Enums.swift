//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//

import SwiftUI
import STools

public enum ScrollDirection: RawRepresentable, OptionSet {
    case top, bottom, leading, trailing
    public init(rawValue: Int) {
        switch rawValue {
            case 0:
                self = .top
            case 1:
                self = .bottom
            case 2:
                self = .leading
            case 3:
                self = .trailing
            default:
                self = .top
        }
    }
    public var rawValue: Int {
        switch self {
            case .top:
                return 0
            case .bottom:
                return 1
            case .leading:
                return 2
            case .trailing:
                return 3
        }
    }
}

public enum Dragging {
    case initiated, iddle, userEnded
}

public enum ScrollAxis {
    case horizontal, vertical
}

public enum PointPosition {
    case min, mid, max
}

public enum OffsetType {
    case padding(Padding)
    case resize(Resize)
}
