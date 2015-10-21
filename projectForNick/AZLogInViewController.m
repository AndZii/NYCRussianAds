//
//  AZLogInViewController.m
//  projectForNick
//
//  Created by Andrii Zykov on 10/18/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "AZLogInViewController.h"
#import <Parse/Parse.h>
#import "CreateUserViewController.h"

@interface AZLogInViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation AZLogInViewController

- (void)viewDidAppear:(BOOL)animated {
    
    if ([PFUser currentUser]) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.passwordTextField.delegate = self;
    
    self.userNameTextField.delegate = self;
    
    self.passwordTextField.returnKeyType = UIReturnKeyGo;
    
    //set up view controller
    
    
}
- (IBAction)logInButtonPressed:(UIButton *)sender {
    
    NSError * error;
    
    [PFUser logInWithUsername:self.userNameTextField.text password:self.passwordTextField.text error:&error];
    
    if (error) {
        
        NSLog(@"%@ - error", error.localizedDescription);
        
    }
    
    if ([PFUser currentUser]) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}
- (IBAction)createNewAccountButtonPressed:(UIButton *)sender {
    
    CreateUserViewController * createNewUserController = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateUserViewController"];
    
    [self presentViewController:createNewUserController animated:YES completion:nil];
    
}
- (IBAction)forgotPasswordButtonPressed:(id)sender {
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[self view] endEditing:TRUE];
    
}



# pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isEqual:self.passwordTextField]) {
        
        [self logInButtonPressed:nil];
        
    }
    
    if ([textField isEqual:self.userNameTextField]) {
        
        [self.passwordTextField becomeFirstResponder];
        
    }
    
    return YES;
    
}

@end
