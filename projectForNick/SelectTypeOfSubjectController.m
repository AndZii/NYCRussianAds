//
//  SelectTypeOfSubjectController.m
//  NYCRussianAds
//
//  Created by Andrii Zykov on 10/21/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "SelectTypeOfSubjectController.h"
#import "AZDataManager.h"
#import "SubjectsController.h"
#import "AdsDisplayController.h"
#import <Parse/Parse.h>
#import "Ad.h"
@interface SelectTypeOfSubjectController ()

@property (strong, nonatomic) NSArray * arrayWithTypesOfSubjects;

@end

@implementation SelectTypeOfSubjectController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayWithTypesOfSubjects = nil;
    
    if (self.creationOfNewAd) {
        
        NSMutableArray * temp = [NSMutableArray arrayWithArray:[AZDataManager getSubjectTypes]];
        
        [temp removeObject:[temp objectAtIndex:0]];
        
        self.arrayWithTypesOfSubjects = [NSArray arrayWithArray:temp];
        
    } else {
        
        self.arrayWithTypesOfSubjects = [AZDataManager getSubjectTypes];
        
    }
    
}

-(void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    self.navigationController.navigationBar.topItem.title = @"Выбор темы";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return [self.arrayWithTypesOfSubjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString * cellIdentifire = @"cellIdentifire";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifire];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifire];
    }
    
    cell.textLabel.text = [self.arrayWithTypesOfSubjects objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([[self.arrayWithTypesOfSubjects objectAtIndex:indexPath.row] isEqualToString:@"Новые"]) {
        
        // Will open controller to show all ads for spec. subject
        
        PFQuery * subjectQuery = [PFQuery queryWithClassName:@"Ad"];
        
        subjectQuery.limit = 20;
        
        [subjectQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            
            AdsDisplayController * adsDisplayController = [self.storyboard instantiateViewControllerWithIdentifier:@"AdDisplay"];
            
            NSArray * allAdsForSpecificSubject = [Ad fetchAdsFromServerWithArray:objects];
            
            adsDisplayController.arrayOfAds = allAdsForSpecificSubject;
            
            [self.navigationController pushViewController:adsDisplayController animated:YES];
            
        }];
        
        return;
    }
    
    SubjectsController * subjectsController = [self.storyboard instantiateViewControllerWithIdentifier:@"SubjectsController"];
    
    
    NSArray * subjectsForController = [AZDataManager getSubjectsWithType:[self.arrayWithTypesOfSubjects objectAtIndex:indexPath.row]];
    
    subjectsController.creationOfNewAd = self.creationOfNewAd;
    
    subjectsController.subjectsArray = subjectsForController;
    
    [self.navigationController pushViewController:subjectsController animated:YES];
    
}

@end
