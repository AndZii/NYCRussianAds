//
//  AccountViewController.m
//  NYCRussianAds
//
//  Created by Andrii Zykov on 10/23/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "AccountViewController.h"

#import <Parse/Parse.h>
#import "AZLogInViewController.h"
#import "CreateAdViewController.h"
@interface AccountViewController ()
@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsBarButton;

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
     self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:5.f/255.f green:31.f/255.f blue:31.f/255.f alpha:1.f];
//    self.view.backgroundColor =  [UIColor colorWithRed:10.f/255.f green:84.f/255.f blue:82.f/255.f alpha:1];
    
    NSMutableDictionary * attributeStringTitleDictionary = [NSMutableDictionary dictionaryWithObject:[UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:20] forKey:NSFontAttributeName];
    
    [attributeStringTitleDictionary setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    self.navigationItem.title = @"ACCOUNT";
    
    [self.navigationController.navigationBar setTitleTextAttributes:attributeStringTitleDictionary];
    
    [self.settingsBarButton setTintColor:[UIColor whiteColor]];
    
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.testLabel.text = [PFUser currentUser].username;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
}
- (IBAction)postNewAdButonPressed:(UIButton *)sender {
    
    CreateAdViewController * createAdViewController = [[UIStoryboard storyboardWithName:@"CreateAd" bundle:nil] instantiateViewControllerWithIdentifier:@"CreateAdViewController"];
    
    [self.navigationController pushViewController:createAdViewController animated:YES];
    
    
    
}


- (IBAction)logOutButtonPressed:(UIButton *)sender {
   
    UIAlertController * logOutAlertController = [UIAlertController alertControllerWithTitle:nil message:@"Are You Sure You Want To Quit?" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * logOutAlertAction = [UIAlertAction actionWithTitle:@"Log Out" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [PFUser logOut];
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:@"username" forKey:@"username"];
        [defaults setValue:@"password" forKey:@"password"];
        
        AZLogInViewController * loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
        
        
        
        [self presentViewController:loginViewController animated:YES completion:nil];
        
    }];
    
    UIAlertAction * CancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [logOutAlertController addAction:logOutAlertAction];
    
    [logOutAlertController addAction:CancelAction];
    
    [self presentViewController:logOutAlertController animated:YES completion:nil];
    
    
}


@end
