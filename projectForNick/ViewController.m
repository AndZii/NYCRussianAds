//
//  ViewController.m
//  projectForNick
//
//  Created by Andrii Zykov on 10/17/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "ViewController.h"
#import "AZLogInViewController.h"
#import "CreateAdViewController.h"
#import "Ad.h"
#import "AdsDisplayController.h"
#import "SelectTypeOfSubjectController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![PFUser currentUser]) {
        
        AZLogInViewController * logInViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
        
        [self presentViewController:logInViewController animated:YES completion:nil];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
 
    

    self.navigationController.navigationBar.topItem.title =  [NSString stringWithFormat:@"Пользователь, %@",[PFUser currentUser].username ];
    
    
}

#pragma mark - Actions
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.reuseIdentifier isEqualToString:@"logout"]) {
        
        [self logout];
        
    }
    
    if ([cell.reuseIdentifier isEqualToString:@"allAds"]) {
        
        [self showAllAds];
        
    }
    
    if ([cell.reuseIdentifier isEqualToString:@"myAds"]) {
        
        [self showMyAdsOnly];
        
    }
    
    if ([cell.reuseIdentifier isEqualToString:@"postAd"]) {
        
        [self addNewAd];
        
    }
    
}



#pragma mark - main logic

-(void) logout{
    
    [PFUser logOut];
    
    AZLogInViewController * loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
    
    [self presentViewController:loginViewController animated:YES completion:nil];
    
    
}

-(void) showMyAdsOnly {
    
    PFQuery * myQuery = [PFQuery queryWithClassName:@"Ad"];
    
    [myQuery whereKey:@"posted_by" equalTo:[PFUser currentUser]];
    
    [myQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        if (!error) {
            
            NSArray * adsArray = [Ad fetchAdsFromServerWithArray:objects];
            
            AdsDisplayController * adsDisplayViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AdDisplay"];
            
            adsDisplayViewController.arrayOfAds = adsArray;
            
            [self.navigationController pushViewController:adsDisplayViewController animated:YES];
            
        } else {
            
            NSLog(@"%@", error.localizedDescription);
            
        }
        
    }];
    
}

-(void) showAllAds {
    
    SelectTypeOfSubjectController * subjectTypeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SubjectTypeController"];
    
    subjectTypeViewController.creationOfNewAd = NO;
    
    [self.navigationController pushViewController:subjectTypeViewController animated:YES];
    
}

-(void) addNewAd {
    
    SelectTypeOfSubjectController * subjectTypeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SubjectTypeController"];
    
    subjectTypeViewController.creationOfNewAd = YES;
    
    [self.navigationController pushViewController:subjectTypeViewController animated:YES];
    
}

@end
