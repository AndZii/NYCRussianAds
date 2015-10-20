//
//  CreateAdViewController.m
//  NYCRussianAds
//
//  Created by Andrii Zykov on 10/18/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "CreateAdViewController.h"
#import <Parse/Parse.h>
@interface CreateAdViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *textAdField;

@end

@implementation CreateAdViewController


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    
    self.navigationController.navigationBar.topItem.title = @"Добавить новое объявление";
    

    

    
}
- (IBAction)sendButtonPressed:(id)sender {
    
    PFObject *newAd = [PFObject objectWithClassName:@"Ad"];
    
    newAd[@"Title"] = self.titleTextField.text;
    
    newAd[@"Text"]  = self.textAdField.text;
    
    PFUser *user = [PFUser currentUser];
    PFRelation *relation = [newAd relationForKey:@"posted_by"];
    [relation addObject:user];
    
    [newAd saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        if (succeeded) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            
            NSLog(@"%@", error.localizedDescription);
            
        }
        
    }];
    
   
    
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
