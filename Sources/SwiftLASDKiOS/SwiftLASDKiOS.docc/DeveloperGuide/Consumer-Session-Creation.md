# Consumer Session Creation

A client application needs an **FCSDK Web Gateway** **session token** and a **correlation ID** to establish a co-browsing session. When the application calls startSupport, **CBA Live Assist** uses a built-in mechanism to create a session token for the voice and video call, and associates it with a correlation ID for the co-browse. The built-in mechanism provides a standalone, secure mechanism for creating a session token and a correlation ID, but the process is not integrated with any pre-existing authentication and authorization system, and assumes that if a client can invoke startSupport, it is permitted to do so.

If you wish to integrate your **CBA Live Assist** application with an existing authentication and authorization system, you can disable the built-in mechanism (by setting the **Anonymous Consumer Access** setting to disabled using the Web Administration service; see the ***CBA Live Assist Overview and Installation Guide*** for how to do this), and replace it with a bespoke implementation which uses the existing system to authorize and authenticate the client.

Once you have authenticated and authorized the application using the pre-existing system, the application needs to create a session token (see the ***Fusion Client SDK documentation*** for details of how to create the session token) and associate it with a correlation ID.
