//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//

import Foundation
import SwiftUI

@available(iOS 14.0, *)
public struct ComplexScrollViewStyle: ScrollViewStyle {
    @State var anchors = [ReaderChange]()
    public func body(content: AnyView, context: Context) -> some View {
        content
            .preference(key: OffsetPreferenceKey.self, value: context)
//            .onPreferenceChange(ReaderPreferenceKey.self) { value in
//                guard let anchor = value else {return}
//                guard let index = anchors.firstIndex(of: anchor) else {
//                    anchors.append(anchor)
//                    return
//                }
//                anchors[index] = anchor
//            }
    }
    public func makeUIScrollView(_ scrollView: UIScrollView) {
    }
}

//@available(iOS 14.0, *)
//struct Tes: View {
//    var body: some View {
//        VStack {
//            Image("Image5")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(height: 200)
//                .scroll(offset: .resize(height: 100))
//            ScrollView {
//                ForEach(0..<100) { index in
//                    Text("Helllllloooo\(index)")
//                }
//            }.scrollViewStyle(ComplexScrollViewStyle())
//        }
//    }
//}
