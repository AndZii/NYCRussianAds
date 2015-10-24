//
//  AllAdsViewController.m
//  NYCRussianAds
//
//  Created by Andrii Zykov on 10/23/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "AllAdsViewController.h"
#import "AllAdsViewControllerCell.h"
#import <Parse/Parse.h>
#import "AZDataManager.h"
#import "AllAdsBuyCategoryTableViewController.h"
#import "Ad.h"
@interface AllAdsViewController ()

@property (strong, nonatomic) NSArray * allMainCategoriesOfAds;

@property (strong, nonatomic) NSArray * allDetaliesForMainCategories;

@end

@implementation AllAdsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allMainCategoriesOfAds = [AZDataManager getSubjectTypes];
    
    self.allDetaliesForMainCategories = [AZDataManager getDetalesForSubjects];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:5.f/255.f green:31.f/255.f blue:31.f/255.f alpha:1.f];
    
//       self.view.backgroundColor =  [UIColor colorWithRed:10.f/255.f green:84.f/255.f blue:82.f/255.f alpha:1];
    
    NSMutableDictionary * attributeStringTitleDictionary = [NSMutableDictionary dictionaryWithObject:[UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:20] forKey:NSFontAttributeName];
    
    [attributeStringTitleDictionary setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    self.navigationItem.title = @"ALL ADS";
    
    [self.navigationController.navigationBar setTitleTextAttributes:attributeStringTitleDictionary];
    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.allMainCategoriesOfAds count];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentifire = @"AllAdsViewControllerCell";
    
    AllAdsViewControllerCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifire];
    
    if (!cell) {
        
        cell = [[AllAdsViewControllerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifire];
        
    }
    
    cell.customTextLabel.text = [self.allMainCategoriesOfAds objectAtIndex:indexPath.row];
    
    cell.customDetaleTextLable.text = [self.allDetaliesForMainCategories objectAtIndex:indexPath.row];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    
    PFQuery * adsByCategoryQuery = [PFQuery queryWithClassName:@"Ad"];
    
    [adsByCategoryQuery whereKey:@"Subject" equalTo:[self.allMainCategoriesOfAds objectAtIndex:indexPath.row]];
    
    [adsByCategoryQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
       
            AllAdsBuyCategoryTableViewController * allAdsByCategoryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AllAdsBuyCategoryTableViewController"];
        
        if (!error) {
            
            allAdsByCategoryVC.arrayWithAds = [Ad fetchAdsFromServerWithArray:objects];
            
            [self.navigationController pushViewController:allAdsByCategoryVC animated:YES];
            
        }
        
    }];
    
}

@end
