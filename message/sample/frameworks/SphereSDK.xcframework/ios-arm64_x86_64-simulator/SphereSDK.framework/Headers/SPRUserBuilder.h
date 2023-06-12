//
//  SPRUserBuilder.h
//  SphereSDK
//
//  Created by ldja on 2022/09/29.
//  Copyright © 2022 TanD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPRParamBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface SPRUserBuilder : NSObject

@property (nonatomic, strong) NSMutableDictionary *_param;

+ (instancetype)builder;
+ (instancetype)builderWithDictionary:(NSDictionary<NSString *, id> *)dict;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

- (NSDictionary *)build;

- (instancetype)setGender:(nullable NSString *)value;
- (instancetype)setGrade:(nullable NSString *)value;
- (instancetype)setPhone:(nullable NSString *)value;
- (instancetype)setEmail:(nullable NSString *)value;
- (instancetype)setBirthYear:(int)value;
- (instancetype)setUserProperty:(nullable NSString *)value forName:(NSString *)name ;
- (instancetype)setUserPropertyLong:(long)value forName:(NSString *)name;
- (instancetype)setUserPropertyArray:(nullable NSArray *)value forName:(NSString *)name;
- (instancetype)setRemainingPoint:(id)value forName:(nullable NSString *)name;
- (instancetype)setParams:(nullable SPRParamBuilder *) paramBuilder;

- (NSMutableDictionary *) getInfoSet;
- (NSArray *) getAseet;
- (SPRParamBuilder *) getParams;

@end

NS_ASSUME_NONNULL_END
