//
//  AZDataManager.m
//  NYCRussianAds
//
//  Created by Andrii Zykov on 10/21/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "AZDataManager.h"

@implementation AZDataManager

+(NSArray*) getSubjectTypes{
    
    return @[
                               NSLocalizedString(@"New", nil),
                               NSLocalizedString(@"Jobs/Find", nil),
                               NSLocalizedString(@"Jobs/Hiring", nil),
                               NSLocalizedString(@"For Sale", nil),
                               NSLocalizedString(@"Wanted", nil),
                               NSLocalizedString(@"Dates/Events/Meet Ups", nil),
                               NSLocalizedString(@"Services", nil),
                               NSLocalizedString(@"Housing", nil)
                               ];
}

+(NSArray*) getDetalesForSubjects {
    
    return @[
             NSLocalizedString(@"20 newest ads from all categories", nil),
             NSLocalizedString(@"Employees looking for jobs", nil),
             NSLocalizedString(@"Here employers post their ads", nil),
             NSLocalizedString(@"Lot of items for sale", nil),
             NSLocalizedString(@"", nil),
             NSLocalizedString(@"", nil),
             NSLocalizedString(@"", nil),
             NSLocalizedString(@"Rent house, apartment, room etc...", nil)
             ];
    
}

+(NSArray*) getSubjectsWithType:(NSString*)type {
  
    
    if ([type isEqualToString:NSLocalizedString(@"Jobs/Find", nil)] || [type isEqualToString:NSLocalizedString(@"Jobs/Hiring", nil)] ) {
        return @[
                 @"Гостиницы, мотели",
                 @"Программирование, интернет",
                 @"Офис, приемная ",
                 @"Торговля, магазины",
                 @"Авторемонт и сервис",
                 @"Рестораны, клубы, питание",
                 @"Медицина, фитнес",
                 @"Сиделки, home attendants",
                 @"Строительство, ремонт",
                 @"Парикмахерские, SPA",
                 ];
    }
    
    return @[@"Ошибка"];
}

@end
