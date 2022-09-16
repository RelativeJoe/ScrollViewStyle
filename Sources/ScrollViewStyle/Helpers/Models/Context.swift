//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//

import SwiftUI

@available(iOS 13.0, *)
public struct Context: Equatable {
    public var offset: CGPoint
    public var direction: ScrollDirection?
    public var proxy: GeometryProxy?
    public var anchors = [ReaderAnchor]()
}
