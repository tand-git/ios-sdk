//
//  SPRAnalytics.h
//  sphere_analytics
//
//  Created by Hwan on 18/02/2019.
//  Copyright © 2019 TanD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SPRParamBuilder.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(SphereAnalytics)
@interface SPRAnalytics : NSObject

+ (BOOL)configureWithAppKey:(NSString *)appKey NS_SWIFT_NAME(configure(appKey:));

+ (NSString *)sphereId;

+ (void)printSphereId;

+ (void)logEventWithName:(NSString *)name
            paramBuilder:(nullable SPRParamBuilder *)builder NS_SWIFT_NAME(logEvent(_:paramBuilder:));

+ (void)setUserId:(nullable NSString *)userId;

+ (void)setGrade:(nullable NSString *)grade;

+ (void)setEmail:(nullable NSString *)email;

+ (void)setPhoneNumber:(nullable NSString *)number;

+ (void)setGender:(nullable NSString *)gender;

+ (void)setBirthYear:(int)year;

+ (void)setRemainingPoint:(int)point;

+ (void)setTotalEarnedPoint:(int)point;

+ (void)setTotalUsedPoint:(int)point;

+ (void)resetPoints;

+ (void)setUserProperty:(nullable NSString *)value forName:(NSString *)name;

+ (void)resetUserProperties;

+ (void)enableLog:(BOOL)enable;

+ (void)setSessionTimeoutInterval:(NSTimeInterval)timeout;

+ (void)requestUpload;

+ (void)setAppLanguage:(nullable NSString *)language;

+ (void)setAnalyticsCollectionEnabled:(BOOL)enabled;

+ (void)handleOpenUrl:(nullable NSURL *)url;

+ (void)handleContinueUserActivity:(nullable NSUserActivity *)userActivity;

@end

NS_ASSUME_NONNULL_END
