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

#import "NSString+GSVersionComparator.h"
#import "GSComparableVersion.h"

@implementation NSString (GSVersionComparator)

- (NSComparisonResult)gs_compareVersion:(GSComparableVersion *)toVersion {
    GSComparableVersion *cvSelf = [self gs_comparableVersion];
    return [cvSelf compare:toVersion];
}

- (NSComparisonResult)gs_compareVersionToVersionString:(NSString *)toVersionString {
    GSComparableVersion *cvSelf = [self gs_comparableVersion];
    GSComparableVersion *toVersion = [toVersionString gs_comparableVersion];
    return [cvSelf compare:toVersion];
}

- (GSComparableVersion *)gs_comparableVersion {
    return [[GSComparableVersion alloc] initWithVersion:self];
}

- (BOOL)gs_versionGreaterThan:(NSString *)version {
    return ([self gs_compareVersionToVersionString:version] == NSOrderedDescending);
}

- (BOOL)gs_versionLessThan:(NSString *)version {
    return ([self gs_compareVersionToVersionString:version] == NSOrderedAscending);
}

- (BOOL)gs_versionGreaterThanOrEqualTo:(NSString *)version {
    return ([self gs_compareVersionToVersionString:version] >= NSOrderedSame);
}

- (BOOL)gs_versionLessThanOrEqualTo:(NSString *)version {
    return ([self gs_compareVersionToVersionString:version] <= NSOrderedSame);
}

@end