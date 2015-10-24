//
//  AllAdsBuyCategoryTableViewController.m
//  NYCRussianAds
//
//  Created by Andrii Zykov on 10/24/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "AllAdsBuyCategoryTableViewController.h"
#import "AllAdsViewControllerCell.h"
#import "DisplayAdViewController.h"
#import "UIViewController+AddHelpers.h"
@interface AllAdsBuyCategoryTableViewController ()



@end


@implementation AllAdsBuyCategoryTableViewController


-(void) viewDidLoad {
    [self navigationBarCustomOptions];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.arrayWithAds count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentifire = @"AllAdsViewControllerCell";
    
    AllAdsViewControllerCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifire];
    
    if (!cell) {
        
        cell = [[AllAdsViewControllerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifire];
        
    }
    
    Ad * nextAd = [self.arrayWithAds objectAtIndex:indexPath.row];
    
    cell.customTextLabel.text = nextAd.title;
    
//    cell.customDetaleTextLable.text = nextAd.created_at;
    
    return cell;
    
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DisplayAdViewController * displayAdViewCOntroller = [self.storyboard instantiateViewControllerWithIdentifier:@"DisplayAdViewController"];
    
    displayAdViewCOntroller.showAd = [self.arrayWithAds objectAtIndex:indexPath.row];
    
    [self presentViewController:displayAdViewCOntroller animated:YES completion:nil];
    
}

@end
