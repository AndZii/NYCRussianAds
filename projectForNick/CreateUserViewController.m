//
//  CreateUserViewController.m
//  projectForNick
//
//  Created by Andrii Zykov on 10/18/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "CreateUserViewController.h"
#import <Parse/Parse.h>
#import "UIViewController+AddHelpers.h"
@interface CreateUserViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmationField;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet UIButton *createButton;

@property (weak, nonatomic) IBOutlet UIButton *TermsOfServiceButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *signUpConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *veryTopConstraint;

@end


@implementation CreateUserViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[self view] endEditing:TRUE];
    
}

-(void) viewDidLoad {
    [super viewDidLoad];
    

    [self setTextFields];
    
    [self setTermsAndServicesButton];
 
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        self.signUpConstraint.constant = 150.f;
        
        self.veryTopConstraint.constant = 50.f;
        
    }
    
}

-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
     [self.TermsOfServiceButton sizeToFit];
    
}

#pragma mark - UITextFieldDelegate 

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isEqual:self.userNameTextField]) {
        [self.emailTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.emailTextField]) {
        [self.passwordField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.passwordField]) {
        [self.passwordConfirmationField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.passwordConfirmationField]) {
        [self createNewUserPressed:nil];
    }
    
    return YES;
    
}

- (IBAction)createNewUserPressed:(UIButton *)sender {
    

    if (self.userNameTextField.text.length < 3 ||
        self.emailTextField.text.length < 3 ||
        self.passwordField.text.length < 3 ||
        self.passwordConfirmationField.text.length < 3 ||
        ![self.passwordField.text isEqualToString:self.passwordConfirmationField.text]) {
        
        [self showAlertControllerWithMessage:@"Wrong Info"];
        
    }
    
    
    PFUser * newUser = [PFUser user];
    
    newUser.username = self.userNameTextField.text;
    
    newUser.password = self.passwordField.text;
    
    newUser.email = self.emailTextField.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
       
        if (succeeded) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            [self saveUserParams];
            
        } else {
            
            [self showAlertControllerWithMessage:error.localizedDescription];
            
        }
        
    }];
    
    
    
}
- (IBAction)cancelPressed:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
    
    
    [self.TermsOfServiceButton setAttributedTitle:TermsOfService forState:UIControlStateNormal];
    
    self.TermsOfServiceButton.titleLabel.numberOfLines = 2;
    
    self.TermsOfServiceButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

-(void) setTextFields {
    
    NSString * placeholderUserName = @"Username";
    
    NSString * placeholderPassword = @"Password";
    
    NSString * placeholderPasswordConfirmation = @"Password confirmation";
    
    NSString * placeholdereMail = @"Email";
    
    NSDictionary * whiteFontAttributeDictionary = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    
    self.userNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderUserName attributes:whiteFontAttributeDictionary];
    
    self.passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderPassword attributes:whiteFontAttributeDictionary];
    
    self.passwordConfirmationField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderPasswordConfirmation attributes:whiteFontAttributeDictionary];
    
    self.emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholdereMail attributes:whiteFontAttributeDictionary];
    
    self.userNameTextField.delegate = self;
    
    self.passwordConfirmationField.delegate = self;
    
    self.passwordField.delegate = self;
    
    self.emailTextField.delegate = self;
    
}

-(void) saveUserParams {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[PFUser currentUser].username forKey:@"username"];
    [defaults setValue:self.passwordField.text forKey:@"password"];
    
}

@end
