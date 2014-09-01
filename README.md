# GSVersionComparator

A port of Apache Maven's VersionComparator class to Objective-C. This library will support comparing any string whose 
value conforms to the [standard Maven 2.x version numbering scheme.](http://mojo.codehaus.org/versions-maven-plugin/version-rules.html)

[![CI Status](http://img.shields.io/travis/gliders/GSVersionComparator.svg?style=flat)](https://travis-ci.org/gliders/GSVersionComparator)
[![Version](https://img.shields.io/cocoapods/v/GSVersionComparator.svg?style=flat)](http://cocoadocs.org/docsets/GSVersionComparator)
[![License](https://img.shields.io/cocoapods/l/GSVersionComparator.svg?style=flat)](http://cocoadocs.org/docsets/GSVersionComparator)
[![Platform](https://img.shields.io/cocoapods/p/GSVersionComparator.svg?style=flat)](http://cocoadocs.org/docsets/GSVersionComparator)

## Usage

```objective-c
#import "NSString+GSVersionComparator.h"

// Compare iOS versions
if ([[UIDevice currentDevice].systemVersion gs_versionLessThan:@"7.0"]) {
    // Do something specific for iOS 6 and below 
}

// Compare arbitrary version strings
NSURL *apiEndpoint = [NSURL URLWithString:@"http://example.com/2.0/resource"];
NSString *versionComponent = apiEndpoint.pathComponents[1];

NSString *supportedAPIVersion = @"2";

if ([versionComponent gs_versionEquals:supportedAPIVersion]) {
    // Your client supports this api version, it's safe to proceed
}

// Compare complex version strings like '1' and '1.0-0'
BOOL test = [@"1" gs_versionEquals:@"1.0-0"]; // Returns YES
BOOL test = [@"1.0.b" gs_versionGreaterThan:@"1.0.a"]; // Returns YES
BOOL test = [@"1.0" gs_versionLessThan:@"1.0-SNAPSHOT"]; // Returns NO

```

Check the [unit tests](https://github.com/gliders/GSVersionComparator/blob/master/Tests/Test%20Cases/GSVersionComparatorTests.m) for more examples of version strings supported.

## Installation

GSVersionComparator is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "GSVersionComparator"

## Author

[Ryan Brignoni](https://github.com/castral)  
Twitter: [@RyanBrignoni](https://twitter.com/RyanBrignoni)

## License

GSVersionComparator is available under the Apache v2 license. See the LICENSE file for more info.

=======
