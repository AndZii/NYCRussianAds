//
//  EnterTextViewController.m
//  NYCRussianAds
//
//  Created by Andrii Zykov on 10/24/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "EnterTextViewController.h"
#import "UIViewController+AddHelpers.h"
#import <Parse/Parse.h>
@interface EnterTextViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *categoryTextField;
@property (weak, nonatomic) IBOutlet UITextView *textAreaField;
@property (strong, nonatomic) NSString * textViewPlaceholder;

@end

@implementation EnterTextViewController

- (void)viewDidLoad {
    
    NSMutableDictionary * attributeStringTitleDictionary = [NSMutableDictionary dictionaryWithObject:[UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:20] forKey:NSFontAttributeName];
    
    [attributeStringTitleDictionary setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    self.navigationItem.title = @"TITLE";
    
    [self.navigationController.navigationBar setTitleTextAttributes:attributeStringTitleDictionary];
    
    
    [super viewDidLoad];

    self.titleTextField.text = [NSString stringWithFormat:@"Title: \"%@\"",self.adTitle];
    
    self.categoryTextField.text = [NSString stringWithFormat:@"Category: \"%@\"", self.category];
    
    self.textAreaField.delegate = self;
    
    self.textViewPlaceholder = self.textAreaField.text;
    
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:self.textViewPlaceholder]) {
        textView.text = @"";
    }
    
    return YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[self view] endEditing:TRUE];
    
}


- (IBAction)nextButtonPressed:(UIButton*)sender {
    
    PFObject * newAd = [PFObject objectWithClassName:@"Ad"];
    
    [newAd setObject:self.category forKey:@"Subject"];
    
    [newAd setObject:self.adTitle forKey:@"Title"];
    
    [newAd setObject:self.textAreaField.text forKey:@"Text"];
    
    PFRelation * relationsToUser = [newAd relationForKey:@"posted_by"];
    
    [relationsToUser addObject:[PFUser currentUser]];
    
    [newAd saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
       
        if (succeeded) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } else {
            
            [self showAlertControllerWithMessage:error.localizedDescription];
            
        }
        
    }];
    
    
    
}
- (IBAction)cancelButtonPressed:(UIButton *)sender {
    
        [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
