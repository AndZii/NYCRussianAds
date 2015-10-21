//
//  UIFont+SystemFontOverride.m
//  NYCRussianAds
//
//  Created by Andrii Zykov on 10/21/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "UIFont+SystemFontOverride.h"

@implementation UIFont (SystemFontOverride)



#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

+ (UIFont *)boldSystemFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
}

+ (UIFont *)systemFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
}



@end
