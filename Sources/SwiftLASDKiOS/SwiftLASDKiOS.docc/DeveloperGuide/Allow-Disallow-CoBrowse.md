# Allow and Disallow Co-browse for an Agent

You may wish to remove a specific agent from the co-browsing session. To do this, call:

Swift
```swift
await self.sdk?.disallowCobrowse(for: agent)
```

Objective-C
```objective-c
[sdk disallowCobrowseFor:agent completionHandler:^{}];
```

passing in the Agent object received in one of the notifications on the AgentCobrowseDelegate (see the <doc:Dev-AgentCobrowseDelegate> section).

If the agent is already in the co-browse session, they are removed from it; if they are not in the co-browse session, they will not be admitted until the application calls:

Swift
```swift
await self.sdk?.allowCobrowse(for: agent)
```

Objective-C
```objective-c
[sdk allowCobrowseFor:agent completionHandler:^{}];
```

When the application calls allowCobrowseForAgent, the specified agent joins the co-browse immediately.

### Agent accepted into co-browse

When an agent is accepted into the co-browse, the following occurs:

1.  Consumer starts support session.

2.  Agent joins session.

3.  agentJoinedSession callback fired in the consumer application.

4.  Agent requests co-browse.

5.  agentRequestedCobrowse callback fired in the consumer application.

6.  The consumer application has logic that decides the agent is allowed access to the co-browse. This logic could be based on permissions.

7.  Agent is accepted into the co-browse.

8.  Agent joins the co-browse.

9.  agentJoinedCobrowse callback fired in the consumer application.

10. Agent can see the consumer’s screen.

<!--![image_1.png](./image_1.png)-->

### Agent rejected from co-browse

1.  Agent requests co-browse.

2.  agentRequestedCobrowse callback fired in the consumer application, with the agent's permissions.

3.  Consumer application checks the agent permissions, and finds they do not have the required permissions to view the current part of the application.

4.  Consumer application rejects the agent’s request to join the co-browse, and the agent is unable to see the consumer’s screen.

<!--![image_2.png](./image_2.png)-->
