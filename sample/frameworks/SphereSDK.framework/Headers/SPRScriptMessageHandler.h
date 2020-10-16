//
//  SPRScriptMessageHandler.h
//  SphereSDK
//
//  Created by Hwan on 01/08/2019.
//  Copyright © 2019 TanD. All rights reserved.
//

@import WebKit;

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPRScriptMessageHandler : NSObject <WKScriptMessageHandler>

+ (NSString *)handlerName;

+ (BOOL)handlePostMessage:(WKScriptMessage *)message;
+ (BOOL)handlePostMessageBody:(NSDictionary *)messageBody;

@end

NS_ASSUME_NONNULL_END
