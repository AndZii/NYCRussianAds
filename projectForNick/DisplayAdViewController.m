//
//  DisplayAdViewController.m
//  NYCRussianAds
//
//  Created by Andrii Zykov on 10/24/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "DisplayAdViewController.h"

@interface DisplayAdViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleAdLable;
@property (weak, nonatomic) IBOutlet UILabel *textAdLable;
@property (weak, nonatomic) IBOutlet UILabel *PostedByAdLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberAdLabel;

@end

@implementation DisplayAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleAdLable.text = [NSString stringWithFormat:@"Title: \"%@\"",self.showAd.title];
    self.textAdLable.text = self.showAd.text;
    
    PFRelation * relation = self.showAd.posted_by;
    
    PFQuery * usersQuery = [relation query];
    
    __weak UILabel * postedByWeakLable = self.PostedByAdLabel;
    
    __weak UILabel * phoneNumberWeakLable = self.phoneNumberAdLabel;
    
    [usersQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        PFUser * user = [objects firstObject];
        
        postedByWeakLable.text = [NSString stringWithFormat:@"Posted by: %@",[user objectForKey:@"username"] ];
        
        
    }];
    
    
}
- (IBAction)backButtonPressed:(UIButton*)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
