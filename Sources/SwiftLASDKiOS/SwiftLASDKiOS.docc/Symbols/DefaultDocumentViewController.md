# DefaultDocumentViewController

By default, CBA Live Assist displays shared documents on top of the iOS application. The CBA Live Assist iOS SDK allows an application to embed a shared **SharedDocument** in its view hierarchy. For example, an application may want to present a text chat window on top of a shared **SharedDocument**.

## Overview

Swift
```swift
@objc @MainActor final public class DefaultDocumentViewController : UIViewController, UIScrollViewDelegate, LASDKiOS.DocumentViewConstraints {

    /// PushAuthorizationDelegate
    @MainActor final public var documentRequestedAlertController: UIAlertController?
    /// DocumentViewConstraints
    @MainActor final public var topMargin: CGFloat
    @MainActor final public var bottomMargin: CGFloat
    @MainActor final public var leftMargin: CGFloat
    @MainActor final public var rightMargin: CGFloat
    @MainActor override final public func viewDidLoad()

    /// Loads our **DocumentRootView**
    @MainActor override final public func loadView()

    /// When the subviews did layout we update the shareView
    @MainActor override final public func viewDidLayoutSubviews()
}

extension DefaultDocumentViewController : LASDKiOS.PushAuthorizationDelegate {

    /// This method is designed to ask the consumer if the want to allow the **SharedDocument** share or not
    /// - Parameters:
    ///   - sharedDocument: The **SharedDocument** to share
    ///   - allow: A callback to tell the SDK to allow the **SharedDocument** share
    ///   - deny: A callback to tell the SDK to deny the **SharedDocument** share
    @MainActor final public func displaySharedDocumentRequested(_ 
                        sharedDocument: LASDKiOS.SharedDocument, 
                        allow: @escaping @Sendable () -> Void,
                        deny: @escaping @Sendable () -> Void
                        ) async

    /// Dismisses the **UIAlertController**
    @MainActor final public func dismissDialog() async
}
```

Objective-C
```objective-c
    SWIFT_CLASS("_TtC8LASDKiOS29DefaultDocumentViewController")
    @interface DefaultDocumentViewController : UIViewController <DocumentViewConstraints, UIScrollViewDelegate>
    /// PushAuthorizationDelegate
    @property (nonatomic, strong) UIAlertController * _Nullable documentRequestedAlertController;
    /// DocumentViewConstraints
    @property (nonatomic) CGFloat topMargin;
    @property (nonatomic) CGFloat bottomMargin;
    @property (nonatomic) CGFloat leftMargin;
    @property (nonatomic) CGFloat rightMargin;
    - (void)viewDidLoad;
    /// Loads our <em>DocumentRootView</em>
    - (void)loadView;
    /// When the subviews did layout we update the shareView
    - (void)viewDidLayoutSubviews;
    - (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder SWIFT_UNAVAILABLE;
    - (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil SWIFT_UNAVAILABLE;
    @end
    
    @interface DefaultDocumentViewController (SWIFT_EXTENSION(LASDKiOS)) <PushAuthorizationDelegate>
    /// This method is designed to ask the consumer if the want to allow the <em>SharedDocument</em> share or not
    /// \param sharedDocument The <em>SharedDocument</em> to share
    ///
    /// \param allow A callback to tell the SDK to allow the <em>SharedDocument</em> share
    ///
    /// \param deny A callback to tell the SDK to deny the <em>SharedDocument</em> share
    ///
    - (void)displaySharedDocumentRequested:(SharedDocument * _Nonnull)sharedDocument allow:(void (^ _Nonnull)(void))allow deny:(void (^ _Nonnull)(void))deny completionHandler:(void (^     _Nonnull)(void))completionHandler;
    /// Dismisses the <em>UIAlertController</em>
    - (void)dismissDialogWithCompletionHandler:(void (^ _Nonnull)(void))completionHandler;
    @end
```
