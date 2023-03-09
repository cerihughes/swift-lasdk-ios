# URLSession

An extension used to make network calls

## Overview

Swift
```swift
extension URLSession {
    public func codableNetworkWrapper<T>(
                        type: T.Type? = nil, 
                        httpHost: String, 
                        urlPath: String? = nil,
                        httpMethod: String, 
                        httpBody: T? = nil, 
                        timeoutInterval: Double? = nil,
                        headers: [String : String]? = nil
                        ) async throws -> LASDKiOS.ResponseObject where T : Decodable, T : Encodable {}
}
```
