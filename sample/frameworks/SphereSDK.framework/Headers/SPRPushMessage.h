//
//  SPRPushMessage.h
//  SphereSDK
//
//  Created by Hwan on 2020/10/13.
//  Copyright © 2020 TanD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(SpherePushMessage)
@interface SPRPushMessage : NSObject

+ (void)setFcmToken:(nullable NSString *)token;

+ (BOOL)hasFcmToken;

+ (NSString *)setAPNSDeviceToken:(nullable NSData *)deviceToken;
+ (void)setAPNSDeviceTokenString:(nullable NSString *)deviceTokenString;

+ (void)agreePushMessageForInformation:(BOOL)agree;

+ (void)agreePushMessageForAdvertisement:(BOOL)agree;

+ (void)agreePushMessageAtNight:(BOOL)agree;

@end

NS_ASSUME_NONNULL_END
