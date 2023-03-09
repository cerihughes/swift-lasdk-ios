# AssistSDK

The Live Assist SDK

## Overview

Swift
```swift
@objc @MainActor final public class AssistSDK : UIViewController {

    /// Our singleton Object
    @objc @MainActor public static var shared: LASDKiOS.AssistSDK?

    @MainActor override final public func viewDidLoad()

    /// Call this method in order to add the Delegate's that your application is conforming to into LiveAssistSDK
    /// - Parameter delegate: The Degate you are conforming to
    @objc @MainActor final public class func addDelegate(_ delegate: NSObject)

    /// Call this method in order to remove the Delegate's that your application is conforming to into LiveAssistSDK
    /// - Parameter delegate: The Degate you are conforming to
    @objc @MainActor final public class func removeDelegate(_ delegate: NSObject)

    /// This is the entry point for Support Sessions
    /// - Parameter destination: The Agent or Queue
    /// - Returns: An AssistSDK Object
    @objc @MainActor final public class func startSupport(_ config: LASDKiOS.Configuration) async throws -> LASDKiOS.AssistSDK

    /// Call this method when you want to end the **AssistSDK** supportt
    @objc @MainActor final public func endSupport()

    /// We want to parse a potential url into 3 parts and have default values otherwise
    ///  1. Scheme
    ///  2. Host
    ///  3. Port
    /// Examples of configured server addresses we have to deal with are as follows.
    /// Note the requirement to configure IPv6 addresses with []
    /// "//192.168.8.44"
    /// "//192.168.8.44:50"
    /// "//[44::33]"
    /// "//[44::33]:50"
    /// "[44::33]:50"
    /// "192.168.8.44:50"
    /// "http://192.168.8.44:50"
    /// "http://[44::33]:50"
    /// "http://192.168.8.44"
    /// "http://[44::33]"
    /// - Parameters:
    ///   - config: The **AssistSDK** Configuration
    ///   - serverURL: The Server's URL
    /// - Returns: A **ServerObject** used for Session Creation
    @objc @MainActor final public class func parseURL(_ config: LASDKiOS.Configuration?, serverURL: String? = nil) async throws -> LASDKiOS.ServerObject

    ///  Call this menod to share a document of your's from the Client
    /// - Parameters:
    ///   - documentUrl: The Document's URL location
    ///   - consumerShareDelegate: The consumer share delegate
    @objc @MainActor final public func shareDocumentUrl(_ documentUrl: URL, delegate consumerShareDelegate: LASDKiOS.ConsumerDocumentDelegate) async throws

    /// Allow the specified agent to co-browse.
    /// - Parameter agent: The agent in question.
    @objc @MainActor final public func allowCobrowse(for agent: LASDKiOS.Agent) async

    /// Disallow the specified agent from co-browsing.
    /// - Parameter agent: The agent in question.
    @objc @MainActor final public func disallowCobrowse(for agent: LASDKiOS.Agent) async

    /// Allows an active co-browse to be paused.
    @objc @MainActor final public func pauseCobrowse() async

    /// Allows a paused co-browse to be resumed.
    @objc @MainActor final public func resumeCobrowse() async

    /// Set (or remove) a permission marker for a specified view.
    /// - Parameters:
    ///   - permissionMarker: If nil or empty, clear the marker for the specified view.
    ///   - view: The view to use - this method will do nothing if nil.
    @MainActor @objc final public func setPermission(_ permissionMarker: String, for view: UIView) async

    /// Set (or remove) a permission marker on a Web element with the specified id.
    /// - Parameters:
    ///   - permissionMarker: If nil or empty, clear the marker for the specified web element.
    ///   - webElementId: The id attribute of the web element.
    @objc @MainActor final public func setWebPermissions(_ permissionMarker: String?, webElementId: String) async

    /// The application can remove all the permissions from all the elements on an HTML page by calling:
    @objc @MainActor final public func resetAllWebPermissions() async
}

extension AssistSDK : LASDKiOS.AssistErrorReporter {

    /// When an error is reported we tear down the support
    /// - Parameter error: The **LASDKError**
    @MainActor final public func reportError(_ error: LASDKiOS.LASDKErrors)

    /// This method is called when an error is encounter and we want to get notified via the **Notification Center**. This method will onlt fire in **Objective-C**
    /// - Parameter error: The **LASDKError**
    @MainActor final public func assistSDKDidEncounterError(_ error: LASDKiOS.LASDKErrors) async
}
```


Objective-C
```objective-c
    @interface AssistSDK : UIViewController
    /// Our singleton Object
    SWIFT_CLASS_PROPERTY(@property (nonatomic, class, strong) AssistSDK * _Nullable shared;)
    + (AssistSDK * _Nullable)shared SWIFT_WARN_UNUSED_RESULT;
    + (void)setShared:(AssistSDK * _Nullable)value;
    /// The initialization iof our SDK
    - (nonnull instancetype)init SWIFT_UNAVAILABLE;
    + (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
    - (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder SWIFT_UNAVAILABLE;
    - (void)viewDidLoad;
    /// Call this method in order to add the Delegate’s that your application is conforming to into LiveAssistSDK
    /// param delegate The Degate you are conforming to
    ///
    + (void)addDelegate:(NSObject * _Nonnull)delegate;
    /// Call this method in order to remove the Delegate’s that your application is conforming to into LiveAssistSDK
    /// param delegate The Degate you are conforming to
    ///
    + (void)removeDelegate:(NSObject * _Nonnull)delegate;
    /// This is the entry point for Support Sessions
    /// param destination The Agent or Queue
    ///
    ///
    /// returns:
    /// An AssistSDK Object
    + (void)startSupport:(Configuration * _Nonnull)config completionHandler:(void (^ _Nonnull)(AssistSDK * _Nullable, NSError * _Nullable))completionHandler;
    /// Call this method when you want to end the AssistSDK supportt
    - (void)endSupport;
    /// We want to parse a potential url into 3 parts and have default values otherwise
    ///     1. Scheme
    ///     2. Host
    ///     2. Port
    ///     Examples of configured server addresses we have to deal with are as follows.
    ///     Note the requirement to configure IPv6 addresses with []
    ///     “//192.168.8.44”
    ///     “//192.168.8.44:50”
    ///     “//[44::33]”
    ///     “//[44::33]:50”
    ///     “[44::33]:50”
    ///     “192.168.8.44:50”
    ///     “http://192.168.8.44:50”
    ///     “http://[44::33]:50”
    ///     “http://192.168.8.44”
    ///     “http://[44::33]”
    /// param config The AssistSDK Configuration
    ///
    /// param serverURL The Server’s URL
    ///
    ///
    /// returns:
    /// A ServerObject used for Session Creation
    + (void)parseURL:(Configuration * _Nullable)config serverURL:(NSString * _Nullable)serverURL completionHandler:(void (^ _Nonnull)(ServerObject * _Nullable, NSError * _Nullable))completionHandler;
    /// Call this menod to share a document of your’s from the Client
    ///     Parameters:
    ///     documentUrl: The Document’s URL location
    ///     consumerShareDelegate: The consumer share delegate
    - (void)shareDocumentUrl:(NSURL * _Nonnull)documentUrl delegate:(id <ConsumerDocumentDelegate> _Nonnull)consumerShareDelegate completionHandler:(void (^ _Nonnull)(NSError * _Nullable))completionHandler;
    /// Allow the specified agent to co-browse.
    /// param agent The agent in question.
    ///
    - (void)allowCobrowseFor:(Agent * _Nonnull)agent completionHandler:(void (^ _Nonnull)(void))completionHandler;
    /// Disallow the specified agent from co-browsing.
    /// param agent The agent in question.
    ///
    - (void)disallowCobrowseFor:(Agent * _Nonnull)agent completionHandler:(void (^ _Nonnull)(void))completionHandler;
    /// Allows an active co-browse to be paused.
    - (void)pauseCobrowseWithCompletionHandler:(void (^ _Nonnull)(void))completionHandler;
    /// Allows a paused co-browse to be resumed.
    - (void)resumeCobrowseWithCompletionHandler:(void (^ _Nonnull)(void))completionHandler;
    /// Set (or remove) a permission marker for a specified view.
    /// param permissionMarker If nil or empty, clear the marker for the specified view.
    ///
    /// param view The view to use - this method will do nothing if nil.
    ///
    - (void)setPermission:(NSString * _Nonnull)permissionMarker for:(UIView * _Nonnull)view completionHandler:(void (^ _Nonnull)(void))completionHandler;
    /// Set (or remove) a permission marker on a Web element with the specified id.
    /// param permissionMarker If nil or empty, clear the marker for the specified web element.
    ///
    /// param webElementId The id attribute of the web element.
    ///
    - (void)setWebPermissions:(NSString * _Nullable)permissionMarker webElementId:(NSString * _Nonnull)webElementId completionHandler:(void (^ _Nonnull)(void))completionHandler;
    /// The application can remove all the permissions from all the elements on an HTML page by calling:
    - (void)resetAllWebPermissionsWithCompletionHandler:(void (^ _Nonnull)(void))completionHandler;
    - (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil SWIFT_UNAVAILABLE;
    @end
    
    
    
    SWIFT_PROTOCOL("_TtP8LASDKiOS17AssistSDKDelegate_")
    @protocol AssistSDKDelegate
    - (void)cobrowseActiveDidChangeTo:(BOOL)active;
    - (void)supportCallDidEnd;
    @optional
    /// If a Swift App tries to use the** assistSDKDidEncounterError** method to receive error Notifications nothing will happen. Use the AssistErrorReporter protocol instead.
    - (void)assistSDKDidEncounterError:(NSNotification * _Nonnull)notification;
    @end
```
