//
//  NSObject+UIAppearanceSwift.m
//  SearchSample
//
//  Created by limao on 16/5/31.
//  Copyright © 2016年 limao. All rights reserved.
//

#import "NSObject+UIAppearanceSwift.h"

@implementation NSObject (UIAppearanceSwift)

+ (instancetype)appearanceWhenContainedWithin:(Class<UIAppearanceContainer>)containerClass {
    if ([self conformsToProtocol:@protocol(UIAppearance)]) {
        return [(id<UIAppearance>)self appearanceWhenContainedIn:containerClass, nil];
    }
    return nil;
}
@end
