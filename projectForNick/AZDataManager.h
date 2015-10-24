//
//  AZDataManager.h
//  NYCRussianAds
//
//  Created by Andrii Zykov on 10/21/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZDataManager : NSObject
+(NSArray*) getSubjectTypes;
+(NSArray*) getSubjectsWithType:(NSString*)type;
+(NSArray*) getDetalesForSubjects;
@end
