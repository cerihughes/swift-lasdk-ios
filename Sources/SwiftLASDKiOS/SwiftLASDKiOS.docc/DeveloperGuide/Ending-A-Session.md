# Ending a Session

When voice and video is enabled, the **CBA Live Assist** default UI allows the consumer to end the session; otherwise, the session ends when the underlying support call ends. The application can also end the session using the endSupport function.

If **CBA Live Assist** is in co-browse-only mode (see the <doc:LA-without-voice-video> section), the application *must* call endSupport explicitly, because **CBA Live Assist** does not present its default UI to the user.
