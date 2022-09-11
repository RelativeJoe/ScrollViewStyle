//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//

import SwiftUI

@available(iOS 13.0, *)
public struct Context: Equatable {
    var offset: CGFloat
    var direction: ScrollDirection?
    var proxy: GeometryProxy?
}

