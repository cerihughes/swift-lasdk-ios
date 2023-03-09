# IPv6 Support

With the release of iOS 9, Apple have made IPv6 support mandatory for App Store submissions. OS X 10.11 (El Capitan) provides the ability to create an IPv6 only Wi-Fi hotspot, which mobile devices can connect to during testing.

The Apple Developer document, [UnderstandingandPreparingfortheIPv6Transition](https://developer.apple.com/library/prerelease/watchos/documentation/NetworkingInternetWeb/Conceptual/NetworkingOverview/UnderstandingandPreparingfortheIPv6Transition/UnderstandingandPreparingfortheIPv6Transition.html), is a useful resource explaining how to set up such a network, and things to consider when ensuring your application operates in an IPv6-only network .

Use the following steps to test a **CBA Live Assist**-enabled application in an IPv6-enabled network:

1.  Set up an IPv6-only Wi-Fi hotspot using the built-in utility, as described above.

2.  Connect to this network from a computer, and obtain the IPv6 address of your **CBA Live Assist** cluster by running the following command:
    
      - Linux: ping6 FQDN-address-of-cluster
    
      - Windows: ping -6 FQDN-address-of-cluster

<!-- end list -->

3.  Connect your Apple mobile device to the hotspot.

4.  Have your application pass in an IPv6 address or URL (as returned from ping6), or the FQDN of your **CBA Live Assist** cluster, as the server parameter of your call to startSupport.

**Note:** An IPv6 server address or URL passed as a server argument must be surrounded by \[ \] regardless of whether the server is a URL, or just an address, or whether a port is specified. For example \[fe80::7aca:39ff:feb4:1002\]:8080. This does not apply when using an FQDN.
