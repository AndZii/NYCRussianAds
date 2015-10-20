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
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    if (![PFUser currentUser]) {
        
        AZLogInViewController * logInViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
        
        [self presentViewController:logInViewController animated:YES completion:nil];
        
    }
    

    self.navigationController.navigationBar.topItem.title =  [NSString stringWithFormat:@"Пользователь, %@",[PFUser currentUser].username ];
    
    
}

#pragma mark - buttons

- (IBAction)signOutButtonPressed:(UIBarButtonItem *)sender {
    
    [PFUser logOut];
    
    AZLogInViewController * loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
    
    [self presentViewController:loginViewController animated:YES completion:nil];
    
    
}


- (IBAction)postNewAd:(UIButton *)sender {
    
    CreateAdViewController * createAdViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateAdViewController"];
    
    [self.navigationController pushViewController:createAdViewController animated:YES];
    
}
- (IBAction)myAddsButtonPressed:(id)sender {
    
    PFQuery * myQuery = [PFQuery queryWithClassName:@"Ad"];
    
    [myQuery whereKey:@"posted_by" equalTo:[PFUser currentUser]];
    
    [myQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
       
        if (!error) {
            
            NSArray * adsArray = [Ad fetchAdsFromServerWithArray:objects];
            
            AdsDisplayController * adsDisplayViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AdDisplay"];
            
            NSLog(@"%li", [adsArray count]);
            
            adsDisplayViewController.arrayOfAds = adsArray;
            
            [self.navigationController pushViewController:adsDisplayViewController animated:YES];
            
        } else {
            
            NSLog(@"%@", error.localizedDescription);
            
        }
        
    }];
    
}

@end
