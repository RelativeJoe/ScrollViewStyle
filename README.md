# ScrollViewStyle

Usage example:

 1. Add a property to track the state of the `ScrollView`
    ```
    @ScrollState var state
    ```
 2. Use the `scrollViewStyle` modifier
    ```
    .scrollViewStyle(.defaultStyle($state))
    ```
TestView

```
struct TestView: View {
    @ScrollState var state
    var body: some View {
        ScrollView {
            ...
        }.scrollViewStyle(.defaultStyle($state))
        .onChange(of: state.isDragging) { newValue in
            print(newValue)
        }
    }
}
```
