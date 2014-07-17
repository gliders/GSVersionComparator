//
//  GSVersionComparatorTests.m
//  GSVersionComparatorTests
//
//  Created by Ryan Brignoni on 07/16/2014.
//  Copyright (c) 2014 Ryan Brignoni. All rights reserved.
//

#import <XCTest/XCTestCase.h>
#import "GSComparableVersion.h"

@interface GSComparableVersionTest : XCTestCase
@property (nonatomic, strong) NSArray *versionsQualifier;
@property (nonatomic, strong) NSArray *versionsNumber;
@end

@implementation GSComparableVersionTest

- (void)setUp {
    if (!self.versionsQualifier) {
        self.versionsQualifier = @[@"1-alpha2snapshot", @"1-alpha2", @"1-alpha-123", @"1-beta-2", @"1-beta123", @"1-m2", @"1-m11", @"1-rc", @"1-cr2",
                @"1-rc123", @"1-SNAPSHOT", @"1", @"1-sp", @"1-sp2", @"1-sp123", @"1-abc", @"1-def", @"1-pom-1", @"1-1-snapshot",
                @"1-1", @"1-2", @"1-123"];

        self.versionsNumber = @[@"2.0", @"2-1", @"2.0.a", @"2.0.0.a", @"2.0.2", @"2.0.123", @"2.1.0", @"2.1-a", @"2.1b", @"2.1-c", @"2.1-1", @"2.1.0.1",
                @"2.2", @"2.123", @"11.a2", @"11.a11", @"11.b2", @"11.b11", @"11.m2", @"11.m11", @"11", @"11.a", @"11b", @"11c", @"11m"];
    }
}

- (void)checkVersionsOrder:(NSArray *)versions {
    NSMutableArray *c = [NSMutableArray arrayWithCapacity:versions.count];
    for (NSString *version in versions) {
        [c addObject:[[GSComparableVersion alloc] initWithVersion:version]];
    }

    for (int i = 1; i < versions.count; i++) {
        GSComparableVersion *low = [c objectAtIndex:i - 1];
        for (int j = i; j < versions.count; j++) {
            GSComparableVersion *high = [c objectAtIndex:j];

            XCTAssertTrue([low compare:high] < 0, @"expected %@ < %@", low, high);
            XCTAssertTrue([high compare:low] > 0, @"expected %@ > %@", high, low);
        }
    }
}

- (void)checkVersion:(NSString *)version1 equals:(NSString *)version2 {
    GSComparableVersion *c1 = [[GSComparableVersion alloc] initWithVersion:version1];
    GSComparableVersion *c2 = [[GSComparableVersion alloc] initWithVersion:version2];

    XCTAssertTrue([c1 compare:c2] == 0, @"expected %@ == %@", c1, c2);
    XCTAssertTrue([c2 compare:c1] == 0, @"expected %@ == %@", c2, c1);
}

- (void)checkVersion:(NSString *)version1 comesBefore:(NSString *)version2 {
    GSComparableVersion *c1 = [[GSComparableVersion alloc] initWithVersion:version1];
    GSComparableVersion *c2 = [[GSComparableVersion alloc] initWithVersion:version2];

    XCTAssertTrue([c1 compare:c2] < 0, @"expected %@ < %@", c1, c2);
    XCTAssertTrue([c2 compare:c1] > 0, @"expected %@ > %@", c2, c1);
}

- (void)testVersionsQualifier {
    [self checkVersionsOrder:self.versionsQualifier];
}

- (void)testVersionsNumber {
    [self checkVersionsOrder:self.versionsNumber];
}

- (void)testVersionsEqual {
    [self checkVersion:@ "1" equals:@"1"];
    [self checkVersion:@ "1" equals:@"1.0"];
    [self checkVersion:@ "1" equals:@"1.0.0"];
    [self checkVersion:@ "1.0" equals:@"1.0.0"];
    [self checkVersion:@ "1" equals:@"1-0"];
    [self checkVersion:@ "1" equals:@"1.0-0"];
    [self checkVersion:@ "1.0" equals:@"1.0-0"];
    // no separator between number and character
    [self checkVersion:@ "1a" equals:@"1.a"];
    [self checkVersion:@ "1a" equals:@"1-a"];
    [self checkVersion:@ "1a" equals:@"1.0-a"];
    [self checkVersion:@ "1a" equals:@"1.0.0-a"];
    [self checkVersion:@ "1.0a" equals:@"1.0.a"];
    [self checkVersion:@ "1.0.0a" equals:@"1.0.0.a"];
    [self checkVersion:@ "1x" equals:@"1.x"];
    [self checkVersion:@ "1x" equals:@"1-x"];
    [self checkVersion:@ "1x" equals:@"1.0-x"];
    [self checkVersion:@ "1x" equals:@"1.0.0-x"];
    [self checkVersion:@ "1.0x" equals:@"1.0.x"];
    [self checkVersion:@ "1.0.0x" equals:@"1.0.0.x"];

    // aliases
    [self checkVersion:@ "1ga" equals:@"1"];
    [self checkVersion:@ "1final" equals:@"1"];
    [self checkVersion:@ "1cr" equals:@"1rc"];

    // special "aliases" a, b and m for alpha, beta and milestone
    [self checkVersion:@ "1a1" equals:@"1alpha1"];
    [self checkVersion:@ "1b2" equals:@"1beta2"];
    [self checkVersion:@ "1m3" equals:@"1milestone3"];

    // case insensitive
    [self checkVersion:@ "1X" equals:@"1x"];
    [self checkVersion:@ "1A" equals:@"1a"];
    [self checkVersion:@ "1B" equals:@"1b"];
    [self checkVersion:@ "1M" equals:@"1m"];
    [self checkVersion:@ "1Ga" equals:@"1"];
    [self checkVersion:@ "1GA" equals:@"1"];
    [self checkVersion:@ "1Final" equals:@"1"];
    [self checkVersion:@ "1FinaL" equals:@"1"];
    [self checkVersion:@ "1FINAL" equals:@"1"];
    [self checkVersion:@ "1Cr" equals:@"1Rc"];
    [self checkVersion:@ "1cR" equals:@"1rC"];
    [self checkVersion:@ "1m3" equals:@"1Milestone3"];
    [self checkVersion:@ "1m3" equals:@"1MileStone3"];
    [self checkVersion:@ "1m3" equals:@"1MILESTONE3"];
}

- (void)testVersionComparing {
    [self checkVersion:@ "1" comesBefore:@"2"];
    [self checkVersion:@ "1.5" comesBefore:@"2"];
    [self checkVersion:@ "1" comesBefore:@"2.5"];
    [self checkVersion:@ "1.0" comesBefore:@"1.1"];
    [self checkVersion:@ "1.1" comesBefore:@"1.2"];
    [self checkVersion:@ "1.0.0" comesBefore:@"1.1"];
    [self checkVersion:@ "1.0.1" comesBefore:@"1.1"];
    [self checkVersion:@ "1.1" comesBefore:@"1.2.0"];

    [self checkVersion:@ "1.0-alpha-1" comesBefore:@"1.0"];
    [self checkVersion:@ "1.0-alpha-1" comesBefore:@"1.0-alpha-2"];
    [self checkVersion:@ "1.0-alpha-1" comesBefore:@"1.0-beta-1"];

    [self checkVersion:@ "1.0-beta-1" comesBefore:@"1.0-SNAPSHOT"];
    [self checkVersion:@ "1.0-SNAPSHOT" comesBefore:@"1.0"];
    [self checkVersion:@ "1.0-alpha-1-SNAPSHOT" comesBefore:@"1.0-alpha-1"];

    [self checkVersion:@ "1.0" comesBefore:@"1.0-1"];
    [self checkVersion:@ "1.0-1" comesBefore:@"1.0-2"];
    [self checkVersion:@ "1.0.0" comesBefore:@"1.0-1"];

    [self checkVersion:@ "2.0-1" comesBefore:@"2.0.1"];
    [self checkVersion:@ "2.0.1-klm" comesBefore:@"2.0.1-lmn"];
    [self checkVersion:@ "2.0.1" comesBefore:@"2.0.1-xyz"];

    [self checkVersion:@ "2.0.1" comesBefore:@"2.0.1-123"];
    [self checkVersion:@ "2.0.1-xyz" comesBefore:@"2.0.1-123"];
}

@end
