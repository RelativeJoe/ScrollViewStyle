//
//  ScrollListeners.swift
//  
//
//  Created by Joe Maghzal on 21/07/2023.
//

import SwiftUI
import Combine

public extension View {
    func onScroll(_ axis: Axis, _ action: @escaping (CGFloat) async -> Void) -> some View {
        background(
            GeometryReader { reader in
                let height = -reader.frame(in: .named("scroll")).origin.y
                let width = -reader.frame(in: .named("scroll")).origin.x
                Color.clear
                    .preference(key: ViewOffsetPrefrenceKey.self, value: axis == .vertical ? height: width)
            }
        ).onPreferenceChange(ViewOffsetPrefrenceKey.self) { newValue in
            Task {
                await action(newValue)
            }
        }
    }
    func onScrollEnd(_ action: @escaping (CGFloat) async -> Void) -> some View {
        modifier(ScrollDetectorViewModifier(action))
    }
}

struct ScrollDetectorViewModifier: ViewModifier {
//MARK: - Properties
    @State private var detector: CurrentValueSubject<CGFloat, Never>
    @State private var publisher: AnyPublisher<CGFloat, Never>
    private var action: (CGFloat) async -> Void
//MARK: - Initializer
    init(_ action: @escaping (CGFloat) async -> Void) {
        let detector = CurrentValueSubject<CGFloat, Never>(0)
        self.publisher = detector
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .dropFirst()
            .eraseToAnyPublisher()
        self.detector = detector
        self.action = action
    }
//MARK: - Body
    func body(content: Content) -> some View {
        content
            .onPreferenceChange(ViewOffsetPrefrenceKey.self) { newValue in
                detector.send(newValue)
            }.onReceive(publisher) { newValue in
                Task {
                    await action(newValue)
                }
            }
    }
}
