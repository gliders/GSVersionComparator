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

// This category is a port from Java of org.apache.maven.artifact.versioning.ComparableVersion

#import "GSComparableVersion.h"
#import "GSListItem.h"
#import "GSIntegerItem.h"
#import "GSStringItem.h"

@interface GSComparableVersion ()
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *canonicalVersion;
@end

@implementation GSComparableVersion

- (id)initWithVersion:(NSString *)version {
    self = [super init];
    if (self) {
        self.items = [[GSListItem alloc] init];
        [self parse:version];
    }

    return self;
}

- (void)parse:(NSString *)version {
    self.value = version;
    GSListItem *list = self.items;
    NSMutableArray *stack = [NSMutableArray array];
    [stack addObject:self.items];
    BOOL isDigit = NO;
    int startIndex = 0;

    for (int i = 0; i < [version length]; i++) {
        unichar c = [version characterAtIndex:i];
        if (c == '.') {
            if (i == startIndex) {
                [list.list addObject:[[GSIntegerItem alloc] initWithInteger:0]];
            } else {
                [list.list addObject:[self parseItem:[version substringWithRange:NSMakeRange(startIndex, i - startIndex)] asInteger:isDigit]];
            }
            startIndex = i + 1;
        } else if (c == '-') {
            if (i == startIndex) {
                [list.list addObject:[[GSIntegerItem alloc] initWithInteger:0]];
            } else {
                [list.list addObject:[self parseItem:[version substringWithRange:NSMakeRange(startIndex, i - startIndex)] asInteger:isDigit]];
            }

            startIndex = i + 1;

            if (isDigit) {
                [list normalize]; // 1.0-* = 1-*

                if ((i + 1 < [version length]) && isdigit([version characterAtIndex:i + 1])) {
                    // new GSListItem only if previous were digits and new char is a digit,
                    // ie need to differentiate only 1.1 from 1-1
                    [list.list addObject:list = [[GSListItem alloc] init]];
                    [stack addObject:list];
                }
            }
        } else if (isdigit(c)) {
            if (!isDigit && i > startIndex) {
                [list.list addObject:[[GSStringItem alloc] initWithString:[version substringWithRange:NSMakeRange(startIndex, i - startIndex)] andFollowedByDigit:YES]];
                startIndex = i;
            }

            isDigit = YES;
        } else {
            if (isDigit && i > startIndex) {
                [list.list addObject:[self parseItem:[version substringWithRange:NSMakeRange(startIndex, i - startIndex)] asInteger:YES]];
                startIndex = i;
            }

            isDigit = NO;
        }
    }

    if ([version length] > startIndex) {
        [list.list addObject:[self parseItem:[version substringFromIndex:startIndex] asInteger:isDigit]];
    }

    NSEnumerator *stackEnumerator = [stack reverseObjectEnumerator];
    GSListItem *stackItem;
    while ((stackItem = stackEnumerator.nextObject)) {
        [stackItem normalize];
    }

    self.canonicalVersion = self.items.description;
}

- (GSItem *)parseItem:(NSString *)subversion asInteger:(BOOL)asInteger{
    return (asInteger)
            ? [[GSIntegerItem alloc] initWithInteger:[subversion integerValue]]
            : [[GSStringItem alloc] initWithString:subversion andFollowedByDigit:NO];
}

- (NSComparisonResult)compare:(GSComparableVersion *)comparableVersion {
    return [self.items compare:comparableVersion.items];
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendString:self.value];
    [description appendString:@">"];
    return description;
}

@end