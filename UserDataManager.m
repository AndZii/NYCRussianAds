//
//  UserDataManager.m
//  projectForNick
//
//  Created by Andrii Zykov on 10/17/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "UserDataManager.h"

@implementation UserDataManager

+(id) sharedManager {
    
    static UserDataManager * userDataManager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        userDataManager = [[UserDataManager alloc] init];
        
    });
    
    return userDataManager;
    
}

@end
