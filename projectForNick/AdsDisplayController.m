//
//  AdsDisplayController.m
//  NYCRussianAds
//
//  Created by Andrii Zykov on 10/18/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "AdsDisplayController.h"
#import "Ad.h"
@interface AdsDisplayController ()

@end


@implementation AdsDisplayController

#pragma mark -  UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.arrayOfAds count];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentifire = @"cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifire];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifire];
        
    }
    
    Ad * ad = [self.arrayOfAds objectAtIndex:indexPath.row];

   cell.textLabel.text = ad.title;
    
    return cell;
    
}


@end
