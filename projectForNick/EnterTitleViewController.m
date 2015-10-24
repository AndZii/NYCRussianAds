//
//  enterTitleViewController.m
//  NYCRussianAds
//
//  Created by Andrii Zykov on 10/24/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "EnterTitleViewController.h"
#import "EnterTextViewController.h"
#import "UIViewController+AddHelpers.h"
@interface EnterTitleViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *categoryTextField;



@end

@implementation EnterTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSAttributedString * placeholderTitle = [[NSAttributedString alloc] initWithString:@"example: Selling iPhone 6 Plus 64 GB" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    
    self.titleTextField.attributedPlaceholder = placeholderTitle;
    
    NSMutableDictionary * attributeStringTitleDictionary = [NSMutableDictionary dictionaryWithObject:[UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:20] forKey:NSFontAttributeName];
    
    [attributeStringTitleDictionary setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    self.navigationItem.title = @"TITLE";
    
    [self.navigationController.navigationBar setTitleTextAttributes:attributeStringTitleDictionary];
    
    self.categoryTextField.text = [NSString stringWithFormat:@"Category: \"%@\"" ,self.categorie ];
    
}
- (IBAction)nextButtonPressed:(UIButton *)sender {
    
    EnterTextViewController * enterTextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EnterTextViewController"];
    
    if (self.titleTextField.text.length < 5) {
        
        [self showAlertControllerWithMessage:@"Title too short"];
        
    }
    
    enterTextViewController.category = self.categorie;
    
    enterTextViewController.adTitle = self.titleTextField.text;
    
    [self.navigationController pushViewController:enterTextViewController animated:YES];
    
}
- (IBAction)cancelButtonPressed:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[self view] endEditing:TRUE];
    
}

@end
