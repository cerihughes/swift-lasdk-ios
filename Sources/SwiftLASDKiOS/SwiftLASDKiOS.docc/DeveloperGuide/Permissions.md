# Permissions

You can use permissions to prevent an agent from interacting with, or even seeing, a UI control. Whether an agent can see a particular control or not depends upon both the agent's and the control element's **permissions**.

  - **Control element permissions**

Client applications assign permission markers to UI control elements by calling the setPermission class method of the AssistSDK:

Swift
```swift
self.sdk?.setPermission("X", for: view)
```

Objective-C
```objective-c
[sdk setPermission:@"X" for:view completionHandler:^{}];
```

where X is the **permission marker** to be set on the control.

Each UI element has at most one permission marker value; elements which do not have a permission marker inherit their parent element’s permission marker; an element which does not have a permission marker either assigned explicitly or inherited from its parent, is assigned the default permission marker.

The default permission is explained further in the <doc:Permissions> section.

  - **Agent permissions**

Agents have two arrays of permissions, **viewable permissions** and **interactive permissions**. Each array may contain an arbitrary number of values. Agents which are not assigned any permissions have the default permission for both interactive and viewable permission sets.

**CBA Live Assist** grants permissions to the agent when the agent presents a **Session Token Description** to the **CBA Live Assist** server (see the ***CBA Live Assist Agent Console Developer Guide*** for more information about setting agent permissions, and under what circumstances the agent can be implicitly assigned the default permission).

The application can determine an agent's permissions from the Agent object it receives in the methods of the AgentCobrowseDelegate (see the <doc:Dev-AgentCobrowseDelegate> section). If the application needs to examine this, but if it does (for instance, to notify the consumer that a particular control will not be visible to the agent), use the viewable and interactive values in the agent's agentPermissions object.

Swift
```swift
let viewablePermissions = agent.permissions?.viewable
```

Objective-C
```objective-c
NSArray* viewablePermissions = agent.permissions.viewable;
```

**Note:** If the agent specifies **permissions** in the **Session Token Description**, but leaves both the viewable array and interactive array empty, the agent will end up with no permissions, not even the default permission.

The combination of the element's and the agent's permissions determines the visibility of a UI element to an agent. A UI element is visible to a specific agent if, and only if, the agent’s set of viewable permissions contains the permission marker assigned to or inherited by that element. Similarly, an agent may interact with a UI element if and only if the agent’s array of interactive permissions contains the element's permission marker.

Permissions and permission markers are free-form text, which (apart from the reserved default permission) are in the control of the application developer. **CBA Live Assist** will show to the agent those, and only those, elements which the agent has permission to view; but it is up to the application developer to ensure that each agent has the permissions they need, and that the UI elements have corresponding permission markers assigned.

**CBA Live Assist assumption**: When an agent wishes to establish a co-browse, the permissions the agent should have, as defined by the organization’s infrastructure, are known, and can be translated into an equivalent array of permissions in the Session Description.

## Agent and Element Permissions

Permissions are compound such that:

| Permission marker on element | Agent viewable permission set | Agent interactive permission set | Result |
|:-:|:-:|:-:|-|
| X | [“X”] | [“X”] | Agent can view and interact with an element marked with X. |
| X | [“X”] | [] | Agent can view the element marked with X but cannot interact with it. |
| X | [] | [“X”] | Agent can neither view nor interact with the element, because it does not have X in its viewable set. (In order to interact with an element, and agent must first be able to view it.) |
| X | [] | [] | Element marked with X is masked or redacted, as Agent does not have the X permission in its viewable or interactive set. |
| X | [“default”] | [“default”] | Element marked with X is masked or redacted, because Agent does not have the X permission in its viewable or interactive set. |
| X | [“default”] | [“X”] | Agent can neither view nor interact with the element, because it does not have X in its viewable set. |
| X | [“X”] | [“default”] | Agent can view the element, because it has the X permission in its viewable set; it cannot interact with it, because it does not have the X permission in its interactive set. |
| B | [“X”] | [“X”] | Element marked with B is masked or redacted, because Agent has X permission and not B in their permission set. |
|  | [“X”,“default”] | [“X”,“default”] | Agent can view and interact with the element because they have the default permission in their viewable and interactive sets, and the element implicitly has the default permission. |
|  | [“X”] | [“X”] | Element is masked or redacted, because Agent’s sets do not contain the default permission |
|  | [“default”] | [“default”] | Agent can view and interact with the element, because they have the default permission set for their viewable and interactive set. |
|  | [] | [] | Element is masked or redacted, because Agent’s sets do not contains default permission |
|  | [“default”] | [“X”] | Agent can see the element because they have the default permission in their viewable set. They cannot interact with it because they do not have the default permission in their interactive set. |
| B | [“X”] | [“B”] | Element is masked or redacted because the agent’s viewable set does not contain B. The agent may not interact with an element which they cannot see, even though they have the appropriate permission in their interactive permission set. |
| B | [“B”] | [“X”] | Element is viewable, because the agent’s viewable set contains B; the element is not interactive, as the agent’s interactive set does not contain B. |

An agent is granted a permission if a permission (such as A, B, or X) configured in their Session Description matches the permission-marker of the UI element in the application.

**Note:** In some circumstances an agent can be granted the default permission *implicitly*, but that ***is not the same thing as having an empty array of permissions***. In the above table, an empty array of agent permissions means exactly that; a array of permissions containing *only* the default permission may have been granted either implicitly or explicitly.

## Parent and Child Permissions

An element can also inherit permissions through the UI hierarchy: UI elements that are a child of a parent UI element inherit the permission marker of the parent, unless the child specifies a permission marker of its own.

A child element can override its parent permission marker, but it will only be effective if the agent's viewable permission set contains the parent’s permission marker as well as the child's (the agent must be able to see the container in order to interact with an element inside it). This allows the developer to make a child element interactive and the parent element not. An example use of this could be a child button within a parent container, where only the button needs to be interactive.

| Permission marker array on parent element | Permission marker array on child element | Agent viewable permission array | Agent interactive permission array | Result |
|:-:|:-:|:-:|:-:|-|
| A |  | [“A”] | [“A”] | Agent can view and interact with both parent and child element. Child inherits permission marker A. |
| A | A | [“A”] | [“A”] | Agent can view and interact with both parent and child element. |
| A | B | [“A”] | [“A”] | Agent cannot view or interact with child element marked with B. |
| A | B | [“A”,“B”] | [“A”] | Agent can view child element but cannot interact with it |
| A | B | [“A”,“B”] | [“B”] | Agent can view and interact with the child element but cannot interact with the parent. |
| A | B | [“B”] | [“B”] | Agent cannot view or interact with child or parent element as they do not have the parent’s permission marker in their viewable permission set. The agent may not interact with an element which they cannot see, even though they have the appropriate permission in their interactive permission array. |
|  |  | [“default”] | [“default”] | Agent can view and interact with both parent and child elements as they have the default permission in their viewable and interactive permission arrays, and both parent and child elements implicitly have the default permission. |
|  | B | [“B”] | [“B”] | Agent cannot view or interact with child element, because the parent has an implicit default permission marker, and they do not have the default permission in their viewable permission array. The agent may not interact with an element which they cannot see, even though they have the appropriate permission in their interactive permission array. |

## Default Permission

You do not have to assign a permission marker to every UI element which you want agents to view or interact with; every element which does not have or inherit a permission automatically has the default permission marker.

Elements which have the default permission marker are viewable and interactive for any agent which has the default permission. Any agent which has the default permission includes the reserved word default among its array of permissions (as returned in the viewable or interactive sets of the agent object's agentPermissions).

Not every agent has the default permission, and an agent might have the default permission in its viewable permissions, but not in its interactive permissions.

## Permissions in Web Views

The application can add permissions to HTML elements on a web page loaded with UIWebView or WKWebView. To do this, call:

Swift
```swift
await assistSDK?.setWebPermissions("X", webElementId: "ELEMENTID")
```

Objective-C
```objective-c
[sdk setWebPermissions:@"" webElementId:@"" completionHandler:^{}];
```

where X is the **permission marker** to be set, and ELEMENTID is the ID of the web page element. This method provides similar functionality for web pages loaded in UIWebView or WKWebView as is provided for native iOS controls.

The application can remove all the permissions from all the elements on an HTML page by calling:

Swift
```swift
await assistSDK?.resetAllWebPermissions()
```

Objective-C
```objective-c
[sdk resetAllWebPermissionsWithCompletionHandler:^{}];
```

**Note:** The application cannot set permissions on elements within an iframe in an HTML page loaded into a UIWebView or WKWebView; nor will elements in an iframe which have the assist-no-show class (see the ***CBA Live Assist Web Developer Guide***) be masked.
