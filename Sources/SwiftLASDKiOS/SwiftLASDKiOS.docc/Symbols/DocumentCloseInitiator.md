# DocumentCloseInitiator

Reasons for **SharedDocument** Closure

## Overview

Swift
```swift
@objc public enum DocumentCloseInitiator : Int, Sendable {
    case closedByUnknown
    case closedByAgent
    case closedByConsumer
    case closedBySupportEnded

    /// Creates a new instance with the specified raw value.
    ///
    /// If there is no value of the type that corresponds with the specified raw
    /// value, this initializer returns `nil`. For example:
    ///
    ///     enum PaperSize: String {
    ///         case A4, A5, Letter, Legal
    ///     }
    ///
    ///     print(PaperSize(rawValue: "Legal"))
    ///     // Prints "Optional("PaperSize.Legal")"
    ///
    ///     print(PaperSize(rawValue: "Tabloid"))
    ///     // Prints "nil"
    ///
    /// - Parameter rawValue: The raw value to use for the new instance.
    public init?(rawValue: Int)

    /// The raw type that can be used to represent all values of the conforming
    /// type.
    ///
    /// Every distinct value of the conforming type has a corresponding unique
    /// value of the `RawValue` type, but there may be values of the `RawValue`
    /// type that don't have a corresponding value of the conforming type.
    public typealias RawValue = Int

    /// The corresponding value of the raw type.
    ///
    /// A new instance initialized with `rawValue` will be equivalent to this
    /// instance. For example:
    ///
    ///     enum PaperSize: String {
    ///         case A4, A5, Letter, Legal
    ///     }
    ///
    ///     let selectedSize = PaperSize.Letter
    ///     print(selectedSize.rawValue)
    ///     // Prints "Letter"
    ///
    ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
    ///     // Prints "true"
    public var rawValue: Int { get }
}

extension DocumentCloseInitiator : Equatable {}
extension DocumentCloseInitiator : Hashable {}
extension DocumentCloseInitiator : RawRepresentable {}
```

Objective-C
```objective-c
    @class SharedDocument;
    enum DocumentCloseInitiator : NSInteger;
    /// Reasons for <em>SharedDocument</em> Closure
    typedef SWIFT_ENUM(NSInteger, DocumentCloseInitiator, open) {
    DocumentCloseInitiatorClosedByUnknown = 0,
    DocumentCloseInitiatorClosedByAgent = 1,
    DocumentCloseInitiatorClosedByConsumer = 2,
    DocumentCloseInitiatorClosedBySupportEnded = 3,
    };
```
