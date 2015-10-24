//
//  CreateAdViewController.m
//  NYCRussianAds
//
//  Created by Andrii Zykov on 10/24/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "CreateAdViewController.h"
#import "AZDataManager.h"
#import "AllAdsViewControllerCell.h"
#import "EnterTitleViewController.h"
#import "UIViewController+AddHelpers.h"
@interface CreateAdViewController ()

@property (strong, nonatomic) NSMutableArray * allMainCategoriesOfAds;

@property (strong, nonatomic) NSMutableArray * allDetaliesForMainCategories;

@end

@implementation CreateAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navigationBarCustomOptions];
    
    self.allMainCategoriesOfAds = [NSMutableArray arrayWithArray:[AZDataManager getSubjectTypes]];
    
    [self.allMainCategoriesOfAds removeObjectAtIndex:0];
    
    self.allDetaliesForMainCategories = [NSMutableArray arrayWithArray:[AZDataManager getDetalesForSubjects]];
    
    [self.allDetaliesForMainCategories removeObjectAtIndex:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
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
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EnterTitleViewController * enterTitleViewController = [[UIStoryboard storyboardWithName:@"CreateAd" bundle:nil] instantiateViewControllerWithIdentifier:@"EnterTitleViewController"];
    
    enterTitleViewController.categorie = [self.allMainCategoriesOfAds objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:enterTitleViewController animated:YES];
    
}

@end
