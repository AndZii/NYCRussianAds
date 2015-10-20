//
//  UserDataManager.h
//  projectForNick
//
//  Created by Andrii Zykov on 10/17/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
@interface UserDataManager : NSObject

@property (strong, nonatomic) PFUser * currentUser;

+(id) sharedManager;

@end
