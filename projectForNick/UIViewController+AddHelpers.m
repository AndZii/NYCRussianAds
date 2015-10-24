//
//  UIViewController+AddHelpers.m
//  NYCRussianAds
//
//  Created by Andrii Zykov on 10/24/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "UIViewController+AddHelpers.h"

@implementation UIViewController (AddHelpers)


-(void) showAlertControllerWithMessage:(NSString*) message {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:alertAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void) navigationBarCustomOptions {
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
@end
