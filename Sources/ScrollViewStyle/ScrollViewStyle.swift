//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/25/22.
//
import Foundation
import SwiftUI
import Introspect

@available(iOS 13.0, *)
public protocol ScrollViewStyle {
    associatedtype Body: View
//    associatedtype Content: View
    @ViewBuilder @MainActor func body(content: AnyView, context: Context) -> Self.Body
    func makeUIScrollView(_ scrollView: UIScrollView)
}

@available(iOS 13.0, *)
internal extension ScrollViewStyle {
    @ViewBuilder @MainActor func makeBody(context: Context, @ViewBuilder content: @escaping () -> some View) -> some View {
        body(content: AnyView(content()), context: context)
    }
}

//    import SwiftUI
    //import Introspect
    //
    //struct Test: View {
    //    @State var offset: CGFloat = 0
    //    @State var delegate: Coordinator!
    //    var body: some View {
    //        VStack(spacing: 30) {
    //            Image("Profile")
    //                .resizable()
    //                .aspectRatio(contentMode: .fill)
    //                .frame(width: 300, height: 300)
    //                .clipped()
    //                .frame(height: 300 - offset)
    //                .clipped()
    //            ScrollView {
    //                VStack {
    //                    ForEach(1..<9) { index in
    //                        Image("Image\(index)")
    //                            .resizable()
    //                            .aspectRatio(contentMode: .fill)
    //                            .frame(width: 300, height: 200)
    //                            .clipped()
    //                    }
    //                }
    //            }
    //            .introspectScrollView { scrollView in
    //                scrollView.delegate = delegate
    //            }
    //        }.onAppear {
    //            delegate = ScrollViewCoordinator(offset: $offset)
    //        }
    //    }
    //}
    //
    //struct Test_Previews: PreviewProvider {
    //    static var previews: some View {
    //        Test()
    //    }
    //}
    //
    //class ScrollViewCoordinator: NSObject, UIScrollViewDelegate, ObservableObject {
    //    @Binding var offset: CGFloat
    //    init(offset: Binding<CGFloat>) {
    //        self._offset = offset
    //    }
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        self.offset = scrollView.contentOffset.y
    //    }
    //}
    //
    //enum OffsetPosition: RawRepresentable, OptionSet {
    //    case fixed(height: CGFloat)
    //    case flexible(alignment: Alignment, id: String)
    //    case offset(direction: VerticalEdge)
    //    case resize(speed: CGFloat, height: Range<CGFloat>? = nil)
    //    var rawValue: Int {
    //        switch self {
    //            case .fixed:
    //            return 0
    //            case .offset:
    //            return 1
    //            case .flexible:
    //            return 2
    //            case .resize:
    //            return 3
    //        }
    //    }
    //    init(rawValue: Int){
    //        switch rawValue {
    //        case 0:
    //            self = .fixed(height: 0)
    //        case 1:
    //            self = .offset(direction: .bottom)
    //        case 2:
    //            self = .flexible(alignment: .bottom, id: "")
    //        case 3:
    //            self = .resize(speed: 0, height: 0..<0)
    //        default:
    //            self = .fixed(height: 0)
    //        }
    //    }
    //}
    //
    //extension View {
    //    @ViewBuilder func scroll(offset: OffsetPosition) -> some View {
    //        self
    //            .modifier(OffsetViewModifier(offset: offset))
    //    }
    //}
    //
    //struct OffsetViewModifier: ViewModifier {
    //    @EnvironmentObject var coordinator: ScrollViewCoordinator
    //    @State var height: CGFloat = 0
    //    @State var newHeight: CGFloat = 0
    //    let offset: OffsetPosition
    //    @State private var numbers = [32, 78, 38, 28, 38].asCast()
    //    func body(content: Content) -> some View {
    //        content
    //            .frame(height: newHeight)
    //            .onChange(of: .height) { newValue in
    //                height = newValue
    //                guard newHeight == 0 else {return}
    //                newHeight = newValue
    //            }
    //            .onChange(of: coordinator.offset) { newValue in
    //                switch offset {
    //                case .fixed(let height):
    //                    guard height != self.height else {return}
    //                    newHeight = newHeight - newValue
    //                default:
    //                    break
    //                }
    //            }
    //    }
    //}
    //
    //extension View {
    //    @ViewBuilder func onChange(of element: SizeChange, action: @escaping (CGFloat) -> Void) -> some View {
    //        self
    //            .background(
    //                GeometryReader { reader in
    //                    Color.clear
    //                        .onChange(of: element == .height ? reader.frame(in: .global).height: reader.frame(in: .global).width) { newValue in
    //                            action(newValue)
    //                        }
    //                }
    //            )
    //    }
    //    @ViewBuilder func onChange(of element: SizeChange, newValue: Binding<CGFloat>) -> some View {
    //        self
    //            .background(
    //                GeometryReader { reader in
    //                    Color.clear
    //                        .onChange(of: element == .height ? reader.frame(in: .global).height: reader.frame(in: .global).width) { newValuey in
    //                            newValue.wrappedValue = newValuey
    //                        }
    //                }
    //            )
    //    }
    //}
    //
    //enum SizeChange: Int {
    //    case height, width
    //}
//

@available(iOS 13.0, *)
extension View {
    @ViewBuilder func anchor<T: CustomStringConvertible>(id: T) -> some View {
        GeometryReader { reader in
            self
                .preference(key: ReaderPreferenceKey.self, value: ReaderChange(anchor: id.description, reader: reader))
        }
    }
}

@available(iOS 13.0, *)
struct ReaderPreferenceKey: PreferenceKey {
    static var defaultValue: ReaderChange?
    static func reduce(value: inout ReaderChange?, nextValue: () -> ReaderChange?) {
        value = nextValue()
    }
}

@available(iOS 13.0, *)
struct ReaderChange: Equatable {
    static func == (lhs: ReaderChange, rhs: ReaderChange) -> Bool {
        return lhs.anchor == rhs.anchor
    }
    var anchor: String
    var reader: GeometryProxy?
}

public enum OffsetType {
    case padding(edge: Edge, maxValue: CGFloat? = nil, speed: CGFloat? = nil)
    case resize(height: CGFloat, speed: CGFloat? = nil)
}

public extension View {
    @ViewBuilder func scroll(offset: OffsetType) -> some View {
        self
            .modifier(OffsetViewModifier(offset: offset))
    }
}

struct OffsetViewModifier: ViewModifier {
    let offset: OffsetType
    @State var oldHeight: CGFloat = 0
    @State var newHeight: CGFloat = 0
    @State var padding: (Edge, CGFloat) = (.top, 0)
    @Environment(\.prefrenceContext) var context
    func body(content: Content) -> some View {
        content
            .onChange(of: context) { value in
                guard let context = value else {
                    return
                }
                switch offset {
                    case .padding(let edge, let maxValue, let speed):
                        padding.0 = edge
                        let newPadding = context.offset * (speed ?? 100)/100
                        if let maxValue {
                            guard newPadding < maxValue else {return}
                        }
                        padding.1 = newPadding
                    case .resize(let height, let speed):
                        let negativeToAssign = oldHeight - context.offset * (speed ?? 100)/100
                        let positiveToAssign = oldHeight + context.offset * (speed ?? 100)/100
                        if negativeToAssign > height  {
                            newHeight = negativeToAssign
                        }else if positiveToAssign < height {
                            newHeight = positiveToAssign
                        }
                }
            }
            .frame(height: newHeight)
            .onChange(of: .height) { newValue in
                if oldHeight == 0 {
                    oldHeight = newValue
                }
            }
    }
}

@available(iOS 13.0, *)
public struct OffsetPreferenceKey: PreferenceKey {
    public static var defaultValue: Context?
    public static func reduce(value: inout Context?, nextValue: () -> Context?) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder func onChange(of element: SizeChange, action: @escaping (CGFloat) -> Void) -> some View {
        self
            .background(
                GeometryReader { reader in
                    Color.clear
                        .onAppear {
                            action(reader.frame(in: .global).height)
                        }.onChange(of: element == .height ? reader.frame(in: .global).height: reader.frame(in: .global).width) { newValue in
                            action(newValue)
                        }
                }
            )
    }
    @ViewBuilder func onChange(of element: SizeChange, newValue: Binding<CGFloat>) -> some View {
        self
            .onChange(of: element) { value in
                newValue.wrappedValue = value
            }
    }
}

enum SizeChange: Int {
    case height, width
}

internal struct ContextKey: EnvironmentKey {
    internal static let defaultValue: Context? = nil
}

internal extension EnvironmentValues {
    var prefrenceContext: Context? {
        get {
            self[ContextKey.self]
        }
        set {
            self[ContextKey.self] = newValue
        }
    }
}

public extension View {
    func scrollContainer() -> some View {
        self.modifier(PrefrenceContextModifier())
    }
}

struct PrefrenceContextModifier: ViewModifier {
    @State var context: Context?
    func body(content: Content) -> some View {
        content
            .environment(\.prefrenceContext, context)
            .onPreferenceChange(OffsetPreferenceKey.self) { value in
                context = value
            }
    }
}
