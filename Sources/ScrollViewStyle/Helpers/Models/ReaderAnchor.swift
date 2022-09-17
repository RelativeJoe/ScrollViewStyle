//
//  File.swift
//  
//
//  Created by Joe Maghzal on 9/11/22.
//

import SwiftUI

public struct ReaderAnchor {
    public var anchor: String
    public var reader: GeometryProxy?
}

//MARK: - Equatable
extension ReaderAnchor: Equatable {
    public static func == (lhs: ReaderAnchor, rhs: ReaderAnchor) -> Bool {
        return lhs.anchor == rhs.anchor
    }
}
