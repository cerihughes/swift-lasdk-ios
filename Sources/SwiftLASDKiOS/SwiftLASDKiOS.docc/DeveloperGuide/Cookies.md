# Cookies

By default, **CBA Live Assist** does not include cookies on the WebSocket connection that it opens to the **CBA Live Assist** server. If the WebSocket needs to include all the appropriate cookies for the WebSocket URL, you can enable them by providing a useCookies configuration parameter set to true (see the <doc:Session-Configuration> section).

**CBA Live Assist** uses the cookies stored in the HTTPCookieStorage class provided by iOS, so any cookies which should apply to the WebSocket must be in the HTTPCookieStorage singleton *before* invoking startSupport. **CBA Live Assist** uses the cookiesForURL method of HTTPCookieStorage to obtain the collection of applicable cookies for the WebSocket.
