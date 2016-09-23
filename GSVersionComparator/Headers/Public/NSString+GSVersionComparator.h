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

@class GSComparableVersion;

/**
 * A convenience category for using `GSVersionComparator` instances with `NSString`.
 */
@interface NSString (GSVersionComparator)

/**
 * Converts receiver string to an instance of `GSVersionComparator` and compares
 * @param toVersion Version to compare this string with.
 * @return NSComparisonResult @see `GSComparableVersion` -compare:
 */
- (NSComparisonResult)gs_compareVersion:(GSComparableVersion *)toVersion;

/**
 * Converts receiver string to an instance of `GSVersionComparator` and compares
 * @param toVersionString Converted into an instance of `GSVersionComparator`
 * @return NSComparisonResult @see `GSComparableVersion` -compare:
 */
- (NSComparisonResult)gs_compareVersionToVersionString:(NSString *)toVersionString;

/**
 * Converts receiver into an instance of `GSVersionComparator`
 * @return `GSVersionComparison` representation of this version string
 */
- (GSComparableVersion *)gs_comparableVersion;

/**
 * Check if the receiver version string is greater than another version string.
 * @param version Compare receiver to this version string.
 * @return `YES` if greater than other version, otherwise `NO`
 */
- (BOOL)gs_versionGreaterThan:(NSString *)version;

/**
 * Check if the receiver version string is less than another version string.
 * @param version Compare receiver to this version string.
 * @return `YES` if less than other version, otherwise `NO`
 */
- (BOOL)gs_versionLessThan:(NSString *)version;

/**
 * Check if the receiver version string is greater than or equal to another version string.
 * @param version Compare receiver to this version string.
 * @return `YES` if greater than or equal to other version, otherwise `NO`
 */
- (BOOL)gs_versionGreaterThanOrEqualTo:(NSString *)version;

/**
 * Check if the receiver version string is less than or equal to another version string.
 * @param version Compare receiver to this version string.
 * @return `YES` if less than or equal to other version, otherwise `NO`
 */
- (BOOL)gs_versionLessThanOrEqualTo:(NSString *)version;

/**
 * Check if the receiver version string is equal to another version string.
 * @param version Compare receiver to this version string.
 * @return `YES` if equal to other version, otherwise `NO`
 */
- (BOOL)gs_versionEquals:(NSString *)version;

@end