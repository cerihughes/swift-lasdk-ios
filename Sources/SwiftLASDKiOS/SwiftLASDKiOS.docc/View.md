# View

We wrote an extension of a SwiftUI View for you to be able to set tags on a UIView via SwiftUI. This allows for masking features in your SwiftUI Applications. 

## Overview

* Swift
```swift
extension View {

    /// Finds a `UITableViewCell` from a `SwiftUI.List`, or `SwiftUI.List` child. You can attach this directly to the element inside the list.
    public func lasdkTableViewCell(customize: @escaping (UITableViewCell) -> ()) -> some View
    /// Finds a `UIScrollView` from a `SwiftUI.ScrollView`, or `SwiftUI.ScrollView` child.
    public func lasdkScrollView(customize: @escaping (UIScrollView) -> ()) -> some View
    /// Finds the horizontal `UIScrollView` from a `SwiftUI.TabBarView` with tab style `SwiftUI.PageTabViewStyle`.
    /// Customize is called with a `UICollectionView` wrapper, and the horizontal `UIScrollView`.
    @available(iOS 14.0, *)
    public func lasdkPagedTabView(customize: @escaping (UICollectionView, UIScrollView) -> ()) -> some View
    /// Finds a `UITextField` from a `SwiftUI.TextField`
    public func lasdkTextField(customize: @escaping (UITextField) -> ()) -> some View
    /// Finds a `UITextView` from a `SwiftUI.TextEditor`
    public func lasdkTextView(customize: @escaping (UITextView) -> ()) -> some View
    /// Finds a `UISwitch` from a `SwiftUI.Toggle`
    public func lasdkSwitch(customize: @escaping (UISwitch) -> ()) -> some View
    /// Finds a `UISlider` from a `SwiftUI.Slider`
    public func lasdkSlider(customize: @escaping (UISlider) -> ()) -> some View
    /// Finds a `UIStepper` from a `SwiftUI.Stepper`
    public func lasdkStepper(customize: @escaping (UIStepper) -> ()) -> some View
    /// Finds a `UIDatePicker` from a `SwiftUI.DatePicker`
    public func lasdkDatePicker(customize: @escaping (UIDatePicker) -> ()) -> some View
    /// Finds a `UISegmentedControl` from a `SwiftUI.Picker` with style `SegmentedPickerStyle`
    public func lasdkSegmentedControl(customize: @escaping (UISegmentedControl) -> ()) -> some View
}
```

### Implementation

```swift
//We can now set a tag on a SwiftUI view via our callback
TextField("CorrelationId", text:  $appSettings.correlationId)
    .lasdkTextField { view in
    view.tag = 502
}
```
