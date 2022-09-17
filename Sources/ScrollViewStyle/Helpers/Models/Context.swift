//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//

import SwiftUI

public struct Context: Equatable {
    public var offset: CGPoint
    public var direction: ScrollDirection?
    public var proxy: GeometryProxy?
    public var state: Dragging?
    public var anchors = [ReaderAnchor]()
}
