//
//  NSObject+UIAppearanceSwift.h
//  SearchSample
//
//  Created by limao on 16/5/31.
//  Copyright © 2016年 limao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (UIAppearance_Swift)

+ (instancetype)appearanceWhenContainedWithin:(Class<UIAppearanceContainer>)containerClass;

@end
