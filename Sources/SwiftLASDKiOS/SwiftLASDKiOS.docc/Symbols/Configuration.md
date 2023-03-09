# Configuration

Our **LASDKiOS** *Configuration* Object

## Overview

Swift
```swift
@objc final public class Configuration : NSObject, ObservableObject, Sendable {

    /// The Assist Server to use for this session. This can be just the name (or IP address) of the server or a URL without a path (The URL is just used to specify the protocol and port. An example is: https://demoserver.test.com:8443 ).
    @objc final public var server: String

    /// AuditName
    @objc final public var auditName: String

    /// A Boolean that when set to true allow us to auto start **LASDKiOS**
    @Published @objc final public var autoStart: Bool

    final public var $autoStart: Published<Bool>.Publisher

    /// The protocol used for view constraints intended for our shared Documents
    @objc weak final public var documentViewConstraints: LASDKiOS.DocumentViewConstraints?

    /// A protocol used for ScreenSharing permissions
    weak final public var screenShareRequestedDelegate: LASDKiOS.ScreenShareRequestedDelegate?

    /// Conform to this delegate on order to get permission to authorize document share
    weak final public var pushDelegate: LASDKiOS.PushAuthorizationDelegate?

    /// The Configurations Initialization
    /// - Parameters:
    ///   - server: The Assist Server to use for this session. This can be just the name (or IP address) of the server or a URL without a path (The URL is just used to specify the protocol and port. An example is: https://demoserver.test.com:8443 ).
    ///   - autoStart: A Boolean that when set to true allow us to auto start **LASDKiOS**
    ///   - destination: The destination of the call. This could be an agent or queue name. It can also be a full sip URL).
    ///   - hidingTags: An array of tag numbers used to identify which UI elements should be obscured with a black rectangle on the agent side when screen sharing.
    ///   - maskingTags: An array of tag numbers used to identify which UI elements should be masked on the agent side when screen sharing.
    ///   - maskColor: UIColor The color to use when masking UI elements.
    ///   - correlationId: Used to map screensharing sessions that uses external audio/video.
    ///   - uui: A user to user header value to include in outbound SIP message for external correlation purposes
    ///   - timeout: How long (approximatively) should we wait to establish the communication with the server before we give up in seconds.
    ///   - sessionToken: A pre-created session ID that will be used to establish connections
    ///   - useCookies: A Boolean used to determine whether whether cookies set up to be sent to the Live Assist server should be sent on the web socket connection
    ///   - connection:
    ///   - videoMode: An enumeration that sets the video mode of a call (full, agentOnly or none). Default is full.
    ///   - addSharedDocCloseLink: A Boolean value to indicate to add a shared doc close link
    ///   - acceptSelfSignedCerts: A Boolean that indicates if we should accept self-signed security certificates or not.  Absence of this attribute will automatically lead to the refusal of self-signed certificates.
    ///   - keepAnnotationsOnChange: A Boolean that indicates whether annotations are retained when the content behind them changes
    ///   - isAgentWindowOnTop: Set to true to force the agent window to be topmost.
    ///   - auditName: Audit Name
    ///   - agentName: Agent Name
    ///   - connectionDelegate:
    ///   - retryIntervals: Indicates the number of automatic reconnection attempts, and the time in seconds between each attempt. See the Connection Configuration section. If an empty array is specified, then no reconnection attempt is made.**[1.0, 2.0, 4.0, 8.0, 16.0, 32.0]**
    ///   - initialConnectionTimeout: Initial connection timeout
    ///   - maxReconnectTimeouts: Max reconnection timeouts
    ///   - permissionsColors: A dictionary of permission Colors
    ///   - screenShareRequestedDelegate: A protocol used for ScreenSharing permissions
    ///   - pushDelegate: Conform to this delegate on order to get permission to authorize document share
    ///   - documentViewConstraints: The protocol used for view constraints intended for our shared Documents
    public init(
                server: String = "", 
                autoStart: Bool = false,
                destination: String = "",
                hidingTags: [Int] = [],
                maskingTags: [Int] = [],
                maskColor: UIColor = .black, 
                correlationId: String = "", 
                uui: String = "", 
                timeout: Float = 5.0, 
                sessionToken: String = "", 
                useCookies: Bool = false, 
                connection: Bool = false, 
                videoMode: LASDKiOS.VideoMode = .full, 
                addSharedDocCloseLink: Bool = true, 
                acceptSelfSignedCerts: Bool = false, 
                keepAnnotationsOnChange: Bool = false,
                isAgentWindowOnTop: Bool = false,
                auditName: String = "", 
                agentName: String = "",
                connectionDelegate: LASDKiOS.ConnectionStatusDelegate? = nil,
                retryIntervals: [Float] = [],
                initialConnectionTimeout: Int = 0,
                maxReconnectTimeouts: [Float] = [0.0],
                permissionsColors: [String : UIColor] = [:],
                screenShareRequestedDelegate: LASDKiOS.ScreenShareRequestedDelegate? = nil, 
                pushDelegate: LASDKiOS.PushAuthorizationDelegate? = nil, 
                documentViewConstraints: LASDKiOS.DocumentViewConstraints? = nil, 
                isProgrammaticUI: Bool = false
                )

    /// The Description of this Configuration
    override final public var description: String { get }

    /// The type of publisher that emits before the object has changed.
    public typealias ObjectWillChangePublisher = ObservableObjectPublisher
}
```

Objective-C
```objective-c 
    /// Our LASDKiOS Configuration Object
    SWIFT_CLASS("_TtC8LASDKiOS13Configuration")
    @interface Configuration : NSObject
    /// The Assist Server to use for this session. This can be just the name (or IP address) of the server or a URL without a path (The URL is just used to specify the protocol and port. An example is:   https://demoserver.test.com:8443 ).
    @property (nonatomic, copy) NSString * _Nonnull server;
    /// AuditName
    @property (nonatomic, copy) NSString * _Nonnull auditName;
    /// A Boolean that when set to true allow us to auto start <em>LASDKiOS</em>
    @property (nonatomic) BOOL autoStart;
    /// The protocol used for view constraints intended for our shared Documents
    @property (nonatomic, weak) id <DocumentViewConstraints> _Nullable documentViewConstraints;
    /// The Configurations Initialization
    /// param server The Assist Server to use for this session. This can be just the name (or IP address) of the server or a URL without a path (The URL is just used to specify the protocol and port. An example is: https://demoserver.test.com:8443 ).
    /// param autoStart A Boolean that when set to true allow us to auto start <em>LASDKiOS</em>
    /// param destination The destination of the call. This could be an agent or queue name. It can also be a full sip URL).
    /// param hidingTags An array of tag numbers used to identify which UI elements should be obscured with a black rectangle on the agent side when screen sharing.
    /// param maskingTags An array of tag numbers used to identify which UI elements should be masked on the agent side when screen sharing.
    /// param maskColor UIColor The color to use when masking UI elements.
    /// param correlationId Used to map screensharing sessions that uses external audio/video.
    /// param uui A user to user header value to include in outbound SIP message for external correlation purposes
    /// param timeout How long (approximatively) should we wait to establish the communication with the server before we give up in seconds.
    /// param sessionToken A pre-created session ID that will be used to establish connections
    /// param useCookies A Boolean used to determine whether whether cookies set up to be sent to the Live Assist server should be sent on the web socket connection
    /// param connection 
    /// param videoMode An enumeration that sets the video mode of a call (full, agentOnly or none). Default is full.
    /// param addSharedDocCloseLink A Boolean value to indicate to add a shared doc close link
    /// param acceptSelfSignedCerts A Boolean that indicates if we should accept self-signed security certificates or not.  Absence of this attribute will automatically lead to the refusal of self-signed certificates.
    /// param keepAnnotationsOnChange A Boolean that indicates whether annotations are retained when the content behind them changes
    /// param isAgentWindowOnTop Set to true to force the agent window to be topmost.
    /// param auditName Audit Name
    /// param agentName Agent Name
    /// param connectionDelegate 
    /// param retryIntervals Indicates the number of automatic reconnection attempts, and the time in seconds between each attempt. See the Connection Configuration section. If an empty array is specified, then no reconnection attempt is made.<em>[1.0, 2.0, 4.0, 8.0, 16.0, 32.0]</em>
    /// param initialConnectionTimeout Initial connection timeout
    /// param maxReconnectTimeouts Max reconnection timeouts
    /// param permissionsColors A dictionary of permission Colors
    /// param screenShareRequestedDelegate A protocol used for ScreenSharing permissions
    /// param pushDelegate Conform to this delegate on order to get permission to authorize document share
    /// param documentViewConstraints The protocol used for view constraints intended for our shared Documents
    - (nonnull instancetype)initWithServer:(NSString * _Nonnull)server 
                autoStart:(BOOL)autoStart 
                destination:(NSString * _Nonnull)destination 
                hidingTags:(NSArray<NSNumber *> * _Nonnull)hidingTags 
                maskingTags:(NSArray<NSNumber *> * _Nonnull)maskingTags 
                maskColor:(UIColor * _Nonnull)maskColor 
                correlationId:(NSString * _Nonnull)correlationId
                uui:(NSString * _Nonnull)uui 
                timeout:(float)timeout 
                sessionToken:(NSString * _Nonnull)sessionToken 
                useCookies:(BOOL)useCookies connection:(BOOL)connection 
                videoMode:(enum VideoMode)videoMode 
                addSharedDocCloseLink:(BOOL)addSharedDocCloseLink 
                acceptSelfSignedCerts:(BOOL)acceptSelfSignedCerts 
                keepAnnotationsOnChange:(BOOL)keepAnnotationsOnChange 
                isAgentWindowOnTop:(BOOL)isAgentWindowOnTop 
                auditName:(NSString * _Nonnull)auditName 
                agentName:(NSString * _Nonnull)agentName 
                connectionDelegate:(id <ConnectionStatusDelegate> _Nullable)connectionDelegate 
                retryIntervals:(NSArray<NSNumber *> * _Nonnull)retryIntervals 
                initialConnectionTimeout:(NSInteger)initialConnectionTimeout
                maxReconnectTimeouts:(NSArray<NSNumber *> * _Nonnull)maxReconnectTimeouts 
                permissionsColors:(NSDictionary<NSString *, UIColor *> * _Nonnull)permissionsColors 
                screenShareRequestedDelegate:(id <ScreenShareRequestedDelegate> _Nullable)screenShareRequestedDelegate 
                pushDelegate:(id <PushAuthorizationDelegate> _Nullable)pushDelegate 
                documentViewConstraints:(id <DocumentViewConstraints> _Nullable)documentViewConstraints 
                isProgrammaticUI:(BOOL)isProgrammaticUI 
                OBJC_DESIGNATED_INITIALIZER;
    /// The Description of this Configuration
    @property (nonatomic, readonly, copy) NSString * _Nonnull description;
    - (nonnull instancetype)init SWIFT_UNAVAILABLE;
    + (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
    @end
```
