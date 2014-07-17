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

@interface NSString (GSVersionComparator)

- (NSComparisonResult)gs_compareVersion:(GSComparableVersion *)toVersion;
- (NSComparisonResult)gs_compareVersionToVersionString:(NSString *)toVersionString;
- (GSComparableVersion *)gs_comparableVersion;

- (BOOL)gs_versionGreaterThan:(NSString *)version;
- (BOOL)gs_versionLessThan:(NSString *)version;
- (BOOL)gs_versionGreaterThanOrEqualTo:(NSString *)version;
- (BOOL)gs_versionLessThanOrEqualTo:(NSString *)version;
- (BOOL)gs_versionEquals:(NSString *)version;
@end