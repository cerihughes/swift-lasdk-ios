# Session Token Creation

A bespoke implementation needs the following general steps:

1.  Create a Web Application that can invoke the **Session Token API** REST Service, exposed by the **FCSDK Web Gateway**.

2.  Provide the appropriate **Fusion Client SDK** (if in use) configuration in a JSON object (the **session description**).

3.  Add **CBA Live Assist**-specific data to the session description:
    
  - AED2.metadata.role

  This should be set to consumer

  - AED2.metadata.auditName

  Optional name to use to identify the consumer in event log entries (see the ***CBA Live Assist Overview and Installation Guide*** for details about event logging.

  - AED2.allowedTopic

  A regular expression which limits the correlation IDs which the session token can be used to connect to. A value of .\* allows the session token to be used to connect to any support session with any correlation ID. For security reasons, we recommend that this should be set to the value of the correlation ID which will actually be used:

JSON
```json
{
...
"voice": {
...
},
"aed": {
"accessibleSessionIdRegex": "customer-ABCDE",
...
},
...
"additionalAttributes": {
"AED2.allowedTopic": "%s",
"AED2.metadata": {
"role": "agent",
"name": "Example Agent",
"permissions":
{ "viewable": ["test", "default"], "interactive": ["go", "text", "default"] }
}
}
...
}
```

4.  Request a session token by sending an HTTP POST request to the **Session Token API**, providing the session description in the body of the POST.

For steps 1, 2, and 4, see the ***FCSDK Developer Guide, Creating the Web Application***.

**Note:** The ***FCSDK Developer Guide*** documents both voice and aed sections - at least one of these must be present to create the session token. However, if the session description includes a voice section (which it must if voice and video functionality is required), then only the AED2 entries are needed for **CBA Live Assist** functionality. If voice and video functionality is not needed, and there is no voice section, then there must be an aed section as well as the AED2 section entries.
