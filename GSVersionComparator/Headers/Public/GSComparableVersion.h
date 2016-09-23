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

#import <Foundation/Foundation.h>

/**
 * `GSComparableVersion` is the main class that provides comparison support for semantic version strings.
 * Internally this class parses and maintains a list of individual version components based on type.
 */

@interface GSComparableVersion : NSObject
/**
 * The original version used to initialize this instance. `nil` values are interpreted as empty strings.
 */
@property (readonly, nullable, nonatomic, copy) NSString *value;

/**
 * Initializes a `GSComparableVersion` object with the specified version string.
 *
 * @param version A string representation of the version. Can be `nil` or empty.
 * @return An initialized `GSComparableVersion` object.
 *
 * @see -compare:
 */
- (nonnull instancetype)initWithVersion:(nullable NSString *)version;

/**
 * Compares an instance of `GSComparableVersion` to this instance to determine ordering. Always ascending order.
 * @param comparableVersion The version to compare against. Can be `nil`.
 * @return `NSOrderedDescending` if this version comes before `comparableVersion`. `NSOrderedAscending` if `comparableVersion` comes after. Otherwise `NSOrderedSame`.
 *
 * @warning Empty and `nil` version strings always sort before versions like `1.0`. Empty and `nil` versions are considered equal to each other.
 */
- (NSComparisonResult)compare:(nullable GSComparableVersion *)comparableVersion;

@end