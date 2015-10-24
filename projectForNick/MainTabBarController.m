//
//  MainTabBarController.m
//  NYCRussianAds
//
//  Created by Andrii Zykov on 10/24/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBar setBarTintColor:[UIColor colorWithRed:5.f/255.f green:38.f/255.f blue:38.f/255.f  alpha:1]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.],
                                                        NSForegroundColorAttributeName : [UIColor grayColor]
                                                        } forState:UIControlStateNormal];
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:15],NSForegroundColorAttributeName : [UIColor whiteColor]
                                                        } forState:UIControlStateSelected];
    
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    // doing this results in an easier to read unselected state then the default iOS 7 one

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
