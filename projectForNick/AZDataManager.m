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
                               @"Новые",
                               @"Работа/ищу",
                               @"Работа/предлогаю",
                               @"Куплю",
                               @"Продам",
                               @"Знакомства",
                               @"Услуги",
                               @"Жилье"
                               ];
}

+(NSArray*) getSubjectsWithType:(NSString*)type {
  
    
    if ([type isEqualToString:@"Работа/ищу"] || [type isEqualToString:@"Работа/предлогаю"] ) {
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
