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

#import "GSListItem.h"

@implementation GSListItem

- (id)init {
    self = [super init];
    if (self) {
        self.list = [NSMutableArray array];
    }

    return self;
}

- (GSItemType)type {
    return LIST_ITEM;
}

- (BOOL)isEmpty {
    return ([self.list count] == 0);
}

- (void)normalize
{
    NSMutableArray *indexesToRemove = [NSMutableArray array];

    for (int i = [self.list count] - 1; i >= 0; i--) {
        GSItem *item = [self.list objectAtIndex:i];
        if (item.isEmpty) {
            [indexesToRemove addObject:[NSNumber numberWithInt:i]];
        } else {
            break;
        }
    }

    for (NSNumber *index in indexesToRemove) {
        [self.list removeObjectAtIndex:[index unsignedIntegerValue]];
    }
}

- (NSComparisonResult)compare:(GSItem *)item {
    if (!item) {
        if (self.list.count == 0) {
            return NSOrderedSame; // 1-0 = 1- (normalize) = 1
        }

        GSItem *first = [self.list objectAtIndex:0];
        return [first compare:nil];
    }


    switch (item.type) {
        case INTEGER_ITEM:
            return NSOrderedAscending; // 1-1 < 1.0.x

        case STRING_ITEM:
            return NSOrderedDescending; // 1-1 > 1-sp

        case LIST_ITEM: {
            NSUInteger left = 0;
            NSUInteger right = 0;
            NSUInteger leftMax = self.list.count;
            NSUInteger rightMax = ((GSListItem *)item).list.count;

            GSItem *l;
            GSItem *r;

            while ((left < leftMax) || (right < rightMax)) {
                l = (left < leftMax) ? [self.list objectAtIndex:left] : nil;
                r = (right < rightMax) ? [((GSListItem *)item).list objectAtIndex:left] : nil;

                left++;
                right++;

                // if this is shorter, then invert the compare and mul with -1
                int result = l == nil ? NSOrderedAscending * [r compare:l] : [l compare:r];
                if (result != 0) {
                    return (NSComparisonResult) result;
                }
            }

            return NSOrderedSame;
        }
        default:
            CTLog(@"error", 0, @"Compared list item to unknown item, %@", item);
            NSException *exception = [NSException exceptionWithName:@"Comparator Error"
                                                             reason:@"Compared list item to unknown item"
                                                           userInfo:nil];
            @throw exception;
    }
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    for (GSItem *item in self.list) {
        [description appendString:item.description];
    }
    [description appendString:@">"];
    return description;
}


@end