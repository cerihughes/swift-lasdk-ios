# During a Co-browse Session

While a co-browsing session is active (after the application has called startSupport successfully, and before either it calls endSupport or receives the supportCallDidEnd notification (see the <doc:AssistSDKDelegate-AssistErrorReporter> section) to indicate that the agent has ended the support session), the application may:

  - Accept an agent into, or expel the agent from, the co-browsing session

  - Pause and resume the co-browsing session

  - Receive a document from the agent

  - Push a document to the agent

  - Receive an **annotation** (a piece of text or drawing to show on the device's screen, overlaid on the application's view) from the agent

  - Have a form on its screen wholly or partly filled in by the agent

Actions which are initiated by the application (such as pushing a document to the agent) require it to call one of the class methods on the AssistSDK object.

Actions initiated by the agent (such as annotating the consumer's screen) can in general be allowed to proceed without interference from the application, as the **CBA Live Assist SDK** manages them, overlaying the user's screen with its own user interface where necessary. However, the application can receive notifications of these events by providing an implementation of one of the various Delegates, and can take control of the operations if it wishes.
