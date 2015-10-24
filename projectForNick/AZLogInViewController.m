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

#import "UIViewController+AddHelpers.h"

@interface AZLogInViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *termsOfServiceButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrainsBetweenAuthinticeteAndSingUp;

@end

@implementation AZLogInViewController

- (void)viewDidAppear:(BOOL)animated {
    
    if ([PFUser currentUser]) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
 
    [self.termsOfServiceButton.titleLabel sizeToFit];
    
   
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        self.constrainsBetweenAuthinticeteAndSingUp.constant = 300.f;
        
    }
    
    self.passwordTextField.delegate = self;
    
    self.userNameTextField.delegate = self;
    
    self.passwordTextField.returnKeyType = UIReturnKeyGo;
    
    NSString * placeholderUserName = @"username";
    
    NSString * placeholderPassword = @"password";
    
    self.userNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderUserName attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderPassword attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    //set up view controller
    
     [self setTermsAndServicesButton];
    
}

- (IBAction)logInButtonPressed:(UIButton *)sender {
    
    [PFUser logInWithUsernameInBackground:self.userNameTextField.text
                                 password:self.passwordTextField.text
                                    block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        
        if (error) {
            
            [self showAlertControllerWithMessage:@"Wrong \nusername or password"];
            
        } else {
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            [self saveUserParams];
        }
        
    }];
  
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

-(void) setTermsAndServicesButton {
    
    NSDictionary * whiteFontAttributeDictionary = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    NSString * tempString = @"By registering, I accept the \nTerms of Service and Privacy Policy.";
    
    NSMutableAttributedString * TermsOfService = [[NSMutableAttributedString alloc] initWithString:tempString attributes:whiteFontAttributeDictionary];
    
    [TermsOfService addAttribute:NSFontAttributeName
                           value:[UIFont fontWithName:@"Helvetica-Bold" size:18.0]
                           range:[tempString rangeOfString:@"Terms of Service"]];
    
    [TermsOfService addAttribute:NSFontAttributeName
                           value:[UIFont fontWithName:@"Helvetica-Bold" size:18.0]
                           range:[tempString rangeOfString:@"Privacy Policy"]];
    
    
    [self.termsOfServiceButton setAttributedTitle:TermsOfService forState:UIControlStateNormal];
    
    self.termsOfServiceButton.titleLabel.numberOfLines = 2;
    
    self.termsOfServiceButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
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

- (IBAction)passwordResetButtonPressed:(UIButton *)sender {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Reset Password" message:@"Please enter your email address" preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"email";
        textField.textAlignment = NSTextAlignmentCenter;
        
    }];
    
    __weak UIAlertController * alertControllerForBlock = alertController;
    
    UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"Send Request" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [PFUser requestPasswordResetForEmailInBackground:alertControllerForBlock.textFields.firstObject.text block:^(BOOL succeeded, NSError * _Nullable error) {
            
            if (succeeded) {
                
                NSLog(@"OK");
                
            } else {
                
                [self showAlertControllerWithMessage:error.localizedDescription];
                
            }
            
        }];

        
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:alertAction];
    
    [alertController addAction:cancelAction];
    
    
    [self presentViewController:alertController animated:YES completion:^{
        
        [[self view] endEditing:TRUE];
        
    }];
    
    
    
    
}



-(void) saveUserParams {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[PFUser currentUser].username forKey:@"username"];
    [defaults setValue:self.passwordTextField.text forKey:@"password"];
    
}

@end
