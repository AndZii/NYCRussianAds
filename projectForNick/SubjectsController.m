//
//  SubjectsController.m
//  NYCRussianAds
//
//  Created by Andrii Zykov on 10/21/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "SubjectsController.h"
#import "CreateAdViewController.h"
#import "AdsDisplayController.h"
#import <Parse/Parse.h>
#import "Ad.h"

@interface SubjectsController ()

@end

@implementation SubjectsController

- (void)viewDidLoad {
    
    [super viewDidLoad];

 
    
}

-(void) viewDidAppear:(BOOL)animated {
    
    
    [super viewDidAppear:YES];
    
    self.navigationController.navigationBar.topItem.title = @"Выбор группы";
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
   
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [self.subjectsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentifire = @"cellIdentifire";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifire];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifire];
    }
    
    cell.textLabel.text = [self.subjectsArray objectAtIndex:indexPath.row];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.creationOfNewAd) {
        
        //Will open controller to create new AD
        
        CreateAdViewController * createAdViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateAdViewController"];
        
        createAdViewController.subject = [self.subjectsArray objectAtIndex:indexPath.row];
        
        [self presentViewController:createAdViewController animated:YES completion:^{
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }];
        
    } else {
        
        // Will open controller to show all ads for spec. subject
        
        PFQuery * subjectQuery = [PFQuery queryWithClassName:@"Ad"];
        
        [subjectQuery whereKey:@"Subject" equalTo:[self.subjectsArray objectAtIndex:indexPath.row]];
        
        [subjectQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
           
             AdsDisplayController * adsDisplayController = [self.storyboard instantiateViewControllerWithIdentifier:@"AdDisplay"];
            
            NSArray * allAdsForSpecificSubject = [Ad fetchAdsFromServerWithArray:objects];
            
            adsDisplayController.arrayOfAds = allAdsForSpecificSubject;
            
            [self.navigationController pushViewController:adsDisplayController animated:YES];
            
        }];
    }
    

    
}




@end
