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

+ (void)logEventWithName:(NSString *)name
            paramBuilder:(nullable SPRParamBuilder *)builder NS_SWIFT_NAME(logEvent(_:paramBuilder:));
+ (void)logPageViewEventWithPageName:(NSString *)pageName;

+ (void)setUserId:(nullable NSString *)userId;
+ (void)setUserProperty:(nullable NSString *)value forName:(NSString *)name;
+ (void)resetUserProperties;

+ (void)setSessionTimeoutInterval:(NSTimeInterval)timeout;

+ (void)setAnalyticsCollectionEnabled:(BOOL)enabled;
+ (void)enableLog:(BOOL)enable;

+ (void)handleOpenUrl:(nullable NSURL *)url;
+ (void)handleContinueUserActivity:(nullable NSUserActivity *)userActivity;

@end

NS_ASSUME_NONNULL_END
