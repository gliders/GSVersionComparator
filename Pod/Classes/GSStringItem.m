/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
//
// Created by Ryan Brignoni on 6/3/13.
// Copyright (c) 2014 Glider Software, Inc All rights reserved.
//

#import "GSStringItem.h"

@interface GSStringItem ()
@property (nonatomic, strong) NSArray *qualifiers;
@property (nonatomic, strong) NSDictionary *aliases;
@property (nonatomic) NSUInteger releaseVersionIndex;
@property (nonatomic) BOOL followedByDigit;
@end

@implementation GSStringItem

- (id)initWithString:(NSString *)s andFollowedByDigit:(BOOL)followedByDigit {
    self = [super init];

    if (self) {
        self.followedByDigit = followedByDigit;
        self.qualifiers = @[@"alpha", @"beta", @"milestone", @"rc", @"snapshot", @"", @"sp"];
        self.aliases = @{
                @"ga" : @"",
                @"final" : @"",
                @"cr" : @"rc"
        };

        self.releaseVersionIndex = [self.qualifiers indexOfObject:@""];

        if (self.followedByDigit && [s length] == 1) {
            // a1 = alpha-1, b1 = beta-1, m1 = milestone-1
            switch ([s characterAtIndex:0]) {
                case 'a':
                    s = @"alpha";
                    break;
                case 'b':
                    s = @"beta";
                    break;
                case 'm':
                    s = @"milestone";
                    break;
                default:
                    break;
            }
        }
        NSString *value = [self.aliases objectForKey:[s lowercaseString]];
        self.value = (value) ? value : s;
    }

    return self;
}

- (GSItemType)type {
    return STRING_ITEM;
}

- (BOOL)isEmpty {
    return ([[self comparableQualifier:self.value] compare:[NSString stringWithFormat:@"%d", self.releaseVersionIndex]] == 0);
}

- (NSString *)comparableQualifier:(NSString *)qualifier
{
    int i = [self.qualifiers indexOfObject:[qualifier lowercaseString]];
    return i == NSNotFound
            ? [NSString stringWithFormat:@"%d-%@", self.qualifiers.count, qualifier]
            : [NSString stringWithFormat:@"%d", i];
}

- (NSComparisonResult)compare:(GSItem *)item {
    if (!item) {
        // 1-rc < 1, 1-ga > 1
        return [[self comparableQualifier:self.value] compare:[NSString stringWithFormat:@"%d", self.releaseVersionIndex]];
    }

    switch (item.type)
    {
        case INTEGER_ITEM:
            return NSOrderedAscending; // 1.any < 1.1 ?

        case STRING_ITEM: {
            NSComparisonResult result = [[self comparableQualifier:self.value] compare:[self comparableQualifier:item.value] options:NSCaseInsensitiveSearch|NSNumericSearch];
            return result;
        }

        case LIST_ITEM:
            return NSOrderedAscending; // 1.any < 1-1
        default:
            NSLog(@"ERROR: Compared string item to unknown item, %@", item);
            NSException *exception = [NSException exceptionWithName:@"Comparator Error"
                                                             reason:@"Compared string item to unknown item"
                                                           userInfo:nil];
            @throw exception;
    }
}

@end