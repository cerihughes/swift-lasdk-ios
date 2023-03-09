# LoggingLevel

Set the Logging level to control log noise

## Overview

Swift
```swift
@objc public enum LoggingLevel : Int, Sendable {
    case trace
    case debug
    case info
    case notice
    case warning
    case error
    case critical

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

extension LoggingLevel : Equatable {}
extension LoggingLevel : Hashable {}
extension LoggingLevel : RawRepresentable {}
````

Objective-C
```objective-c
    typedef SWIFT_ENUM(NSInteger, LoggingLevel, open) {
    LoggingLevelTrace = 0,
    LoggingLevelDebug = 1,
    LoggingLevelInfo = 2,
    LoggingLevelNotice = 3,
    LoggingLevelWarning = 4,
    LoggingLevelError = 5,
    LoggingLevelCritical = 6,
    };
```
