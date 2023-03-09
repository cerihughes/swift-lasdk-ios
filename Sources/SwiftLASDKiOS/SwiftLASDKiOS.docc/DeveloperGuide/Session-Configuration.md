# Session Configuration

| Property | Default Value or Behavior | Description |
|-|-|-|
| destination | empty string | User name of agent or agent group (String), if that agent or agent group is local to the Web Gateway; otherwise, the full SIP URI of an agent or queue. |
| videoMode | .full | Sets whether to show video (String), and from which parties. Allowed values are: .full, .agentOnly, .none |
| correlationId | empty string | ID of the co-browsing session (String) |
| auditName | empty string | Name to identify the consumer in event logs (see the CBA Live Assist Overview and Installation Guide for more details on event logging). This value should be URL encoded. |
| acceptSelfSignedCerts | false | true or false (Bool). Set to true to asccept self-signed certificates in development environments. See the Accepting Self-Signed Certificates section. |
| useCookies | false | true or false (Bool). Set to true to send cookies set up to be sent to the CBA Live Assist server on to the WebSocket connection. |
| isAgentWindowOnTop | false | true or false (Bool). Set to true to force the agent window to be topmost. |
| hidingTags | empty array | Array of numeric tags to use for obscuring content with black rectangles on the agent console (Array). See the Excluding Elements from Co-browsing section. |
| maskingTags | empty array | Array of numeric tags to use for masking content, making it appear as black or colored boxes on the agent console (Array). See the Excluding Elements from Co-browsing section. |
| maskColor | .balck | Color of boxes to be shown on agent console in place of masked content (UIColor). |
| timeout | 5.0 | Time in seconds to wait to establish communication with the CBA Live Assist server (Float). |
| sessionToken | empty string | FCSDK Web Gateway session token (if required) (NSString). See the Escalating a Call to Include Co-browse section. |
| documentView Constraints | nil | Instance of a class conforming to DocumentViewConstraints. See the Setting Shared Document View Constraints section. |
| addSharedDocClose Listener | true | true or false (Bool). Set to false to remove any Close link from a shared document, so that the agent and consumer cannot manually close the document. |
| keepAnnotationsOn Change | false | true or false (Bool). Set to true to keep annotations when the content behind them changes. Set to false to clear them when the content changes. |
| screenShareRequested Delegate | Presents a UIAlertView to prompt the user to choose whether to accept screen sharing (but see the note at the end) | Instance of a delegate which conforms to ScreenShareRequestedDelegate. Specifying this allows an application to choose whether to accept or reject screen sharing however it sees fit. See the ScreenShareRequestedDelegate section. |
| agentCobrowse Delegate | Presents a UIAlertView to prompt the user to choose whether to accept co-browsing (but see the note at the end) | Instance of a delegate which conforms to AgentCobrowseDelegate. Specifying this allows an application to receive notifications of agents joining and leaving the session. See the AgentCobrowseDelegate section. |
| connectionDelegate | nil | Instance of a delegate which conforms to ASDKConnectionStatusDelegate. Specifying this allows an application to receive notifications of connection events. See the ASDKConnectionStatusDelegate section. |
| pushDelegate | nil | A delegate which conforms to the protocol PushAuthorizationDelegate. Specifying this allows an application to choose whether to accept or reject pushed content however it sees fit. See the PushAuthorizationDelegate section. |
| uui | empty string | The value set is placed in the SIP User to User header in hex-encoded form. **Note:** The UUI can only be used when Anonymous Consumer Access is set to trusted mode. See the CBA Live Assist Architecture Guide for further information. The UUI is ignored if the session token is provided. |
| retryIntervals | [1.0, 2.0, 4.0, 8.0, 16.0, 32.0] | Indicates the number of automatic reconnection attempts, and the time in seconds between each attempt. See the Connection Configuration section. If an empty array is specified, then no reconnection attempt is made. |
| maxReconnect Timeouts | [5.0] | Indicates the maximum times in seconds, until WebSocket reconnection attempts fail. An array of values is given that corresponds to the values in retryIntervals - as each value in retryIntervals is used, the relevant value is used from this array. See the Connection Configuration section. **Note:** If the length of the retryIntervals is greater than that of maxReconnectionTimeouts, then the last value of the maxReconnectionTimeouts array is used for the final attempts. |
| initialConnectTimeout | 30.0 | Indicates the maximum time in seconds until the initial WebSocket connection attempt fails. See the Connection Configuration section. |
| isProgrammaticUI | false | Used to determine needed behavior for LASDKiOS. Set true if you are not using storyboards |

You may intitialize the configuration as indicated bellow

Swift
```swift
let config = Configuration(
    server: supportServerAddess.lowercased(),
    autoStart: true,
    destination:  username.lowercased(),
    maskingTags: tags,
    maskColor: color,
    correlationId: correlationId,
    uui: uui,
    acceptSelfSignedCerts: acceptSelfSignedCerts,
    keepAnnotationsOnChange: true,
    auditName: auditName,
    isProgrammaticUI: true
)
```

Objective-C
```objective-c
Configuration *config = [
    [Configuration alloc]
    initWithServer:@""
    autoStart:true destination:@""
    hidingTags:array
    maskingTags:array2
    maskColor:UIColor.blueColor
    correlationId:@""
    uui:@""
    timeout:0.0f
    sessionToken:@""
    useCookies:false
    connection:false
    videoMode:VideoModeFull
    addSharedDocCloseLink:false
    acceptSelfSignedCerts:true
    keepAnnotationsOnChange:true
    isAgentWindowOnTop:true
    auditName:@""
    agentName:@""
    connectionDelegate:self
    retryIntervals:array3
    initialConnectionTimeout:10
    maxReconnectTimeouts:array4
    permissionsColors:dict
    screenShareRequestedDelegate:self
    pushDelegate:self
    documentViewConstraints:self
    isProgrammaticUI:true
];
```

Then feed it to the `startSupport(_ config: Configuration)` method.

**Note:** The application will not receive calls to assistSDKScreenShareRequested in ScreenShareRequestedDelegate if it supplies an implementation of AgentCobrowseDelegate, even if it also supplies an implementation of assistSDKScreenShareRequested. In this case, only the methods in AgentCobrowseDelegate are called. **CBA Live Assist** only displays the default UI if the application supplies neither screenShareRequestedDelegate nor agentCobrowseDelegate. 

### Escalating a Call to Include Co-browse

In most cases, the application calls startSupport with an agent name, and allows **CBA Live Assist** to set up a call to the agent and implicitly add **CBA Live Assist** support to that call. However, there may be cases where a call to an agent already exists, and the application needs to add **CBA Live Assist** support capabilities. To do this, you need to supply the **session token** and a **correlation ID** in the configuration object which you supply to startSupport; and the agent needs to connect to the same session. The **CBA Live Assist** server provides some support for doing this.

* The application connects to a specific URL on the **CBA Live Assist** server, to request a **short code** (error handling omitted):

Swift
```swift
let serverInfo = try await AssistSDK.parseURL(config)
let host = serverInfo.host
let scheme = serverInfo.scheme
let port = serverInfo.port
let url = "\(scheme)://\(host):\(port)"
let auditName = config.auditName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
var path = "/assistserver/shortcode/create"

if !config.auditName.isEmpty {
    path += "?auditName=\(auditName)"
}

let result = try await URLSession.shared.codableNetworkWrapper(
    type: ShortCode.self,
    httpHost: url,
    urlPath: path,
    httpMethod: "PUT",
    timeoutInterval: 4.0
)

let decodedData = try JSONDecoder().decode(ShortCode.self, from: result.data)
guard let shortCode = decodedData.shortCode else { throw OurErrors.nilShortCode }
```

Objective-C
```objective-c
NSString *url = @"<fas address>/assistserver/shortcode/create"];
NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: url];
[request setHTTPMethod: @"PUT"];

NSURLSessionConfiguration *sc= [NSURLSession sessionWithConfiguration:defaultConfiguration];
NSURLSession *session = [NSURLSession sessionWithConfiguration:sc delegate:nil delegateQueue:nil];
NSURLSessionDataTask *task = [session dataTaskWithRequest:request
completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response,
NSError * _Nullable error) {
NSError *jerror = nil;
NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
options:0 error:&jerror];
NSString *shortcode = dictionary[@"shortCode"];
}];
[task resume];
```


* The application uses the short code in another call to a URL on the **CBA Live Assist** server, and receives a JSON object containing a session token and a correlation ID:

Swift
```swift
var tokenPath = "/assistserver/shortcode/consumer?appkey=\(shortCode)"
if !config.auditName.isEmpty {
    tokenPath += "&auditName=\(auditName)"
}

let tokenResult = try await URLSession.shared.codableNetworkWrapper(
    type: ShortCode.self,
    httpHost: url,
    urlPath: tokenPath,
    httpMethod: "GET",
    timeoutInterval: 4.0
)

var result = try JSONDecoder().decode(ShortCode.self, from: tokenResult.data)
result.shortCode = shortCode
```

Objective-C
```objective-c
NSString url = @"<fas address>/assistserver/shortcode/consumer?appkey=";
url = [url stringByAppendingString: shortcode];
NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: url];
[request setHTTPMethod: @"GET"];

NSURLSessionConfiguration *sc= [NSURLSession sessionWithConfiguration:defaultConfiguration];
NSURLSession *session = [NSURLSession sessionWithConfiguration:sc delegate:nil delegateQueue:nil];
NSURLSessionDataTask *task = [session dataTaskWithRequest:request
completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response,
NSError * _Nullable error) {
NSError *jerror = nil;
NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
options:0 error:&jerror];
NSString *sessionToken = dictionary[@"session-token"];
NSString *correlationId = dictionary[@"cid"];
}];
[task resume];
```
* The application includes those values in the configuration object, and passes it to startSupport:

Swift
```swift
self.config = Configuration(
    server: supportServerAddess.lowercased(),
    destination: "",
    maskColor: .darkGray,
    correlationId: result.cid ?? "",
    uui: uui,
    sessionToken: result.sessionToken ?? "",
    acceptSelfSignedCerts: true,
    auditName: auditName,
    connectionDelegate: connectionViewManager,
    retryIntervals: [2.0, 5.0, 10.0, 15.0],
    initialConnectionTimeout: 2,
    maxReconnectTimeouts: [1.0],
    screenShareRequestedDelegate: self,
    isProgrammaticUI: true
)
guard let config = self.config else { return }

let sdk = try await AssistSDK.startSupport(config)
```

Objective-C
```objective-C
Configuration *configuration;

configuration.sessionToken = sessionToken;
configuration.correlationId = correlationId;

[AssistSDK startSupport:configuration completionHandler:^(AssistSDK *sdk, NSError * error) {}];
```

More configuration can be set in the configuration object. Please see

<doc:Configuration>

<doc:MigratingFromLegacySDK>

* The agent uses the same short code to get a JSON object containing the session token and correlation ID, which it then uses to connect to the same **CBA Live Assist** support session (see the ***CBA Live Assist Agent Console Developer Guide***). Informing the agent of the short code is a matter for the application. It could be something as simple as having it displayed on the consumer's screen and having the consumer read it to the agent on the existing call (this is how the sample application does it).

**Note:**
  - When escalating an existing call, the destination property should *not* be set on the configuration object; in this case, the destination is known implicitly from the existing call.

  - The short code expires after 5 minutes, or when it has been used by both agent and consumer to connect to the same session.

  - If you wish to define an audit name to identify the consumer in event logs (see the ***CBA Live Assist Overview and Installation Guide*** for more details on event logging), include an auditName parameter in the URL which creates the short code:
```Objective-C
/assistserver/shortcode/create?auditName=consumer
```
