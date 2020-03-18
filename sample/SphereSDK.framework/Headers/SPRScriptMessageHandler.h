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

+ (void)handleReceiveScriptMessage:(WKScriptMessage *)message;

@end

NS_ASSUME_NONNULL_END
