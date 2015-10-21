//
//  CreateUserViewController.m
//  projectForNick
//
//  Created by Andrii Zykov on 10/18/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "CreateUserViewController.h"
#import <Parse/Parse.h>
@interface CreateUserViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmationField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@end


@implementation CreateUserViewController
- (IBAction)createNewUserPressed:(UIButton *)sender {

    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Wrong info" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:alertAction];
    
    __block NSString * message = nil;
    
    PFUser * newUser = [PFUser user];
    
    newUser.username = self.userNameTextField.text;
    
    newUser.password = self.passwordField.text;
    
    newUser.email = self.emailTextField.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
       
        if (succeeded) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            
            message = [NSString stringWithFormat:@"%@", error.localizedDescription];
            
        }
        
    }];
    
    if (message) {
        
        [alertController setMessage:message];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
}
- (IBAction)cancelPressed:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
