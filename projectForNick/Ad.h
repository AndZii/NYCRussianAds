//
//  Ad.h
//  NYCRussianAds
//
//  Created by Andrii Zykov on 10/18/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
@interface Ad : NSObject
@property (strong, nonatomic) PFUser * posted_by;
@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSString * text;
@property (strong, nonatomic) NSString * subject;
@property (strong, nonatomic) NSString * created_at;

+(NSArray *) fetchAdsFromServerWithArray:(NSArray *) ads;

@end
