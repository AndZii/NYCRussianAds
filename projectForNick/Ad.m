//
//  Ad.m
//  NYCRussianAds
//
//  Created by Andrii Zykov on 10/18/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "Ad.h"

@implementation Ad

+(NSArray *) fetchAdsFromServerWithArray:(NSArray *) ads {
    
    NSMutableArray * adsArray = [NSMutableArray new];
    
    for (PFObject * obj in ads){
        
        [adsArray addObject:[self getAdWithParseObject:obj]];
    }
    
    return adsArray;
    
}

+(Ad* ) getAdWithParseObject:(PFObject *) obj {
    
    Ad * ad = [Ad new];
    
    ad.title = [obj objectForKey:@"Title"];
    
    ad.text = [obj objectForKey:@"Text"];
    
    ad.subject = [obj objectForKey:@"Subject"];
    
    ad.posted_by = [obj objectForKey:@"posted_by"];
    
    ad.created_at =  [obj valueForKey:@"createdAt"];
    
    return ad;
    
}

@end
