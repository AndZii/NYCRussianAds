//
//  SubjectViewController.m
//  NYCRussianAds
//
//  Created by Andrii Zykov on 10/19/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "SubjectViewController.h"

@interface SubjectViewController ()

@property(strong, nonatomic) NSArray * arrayWithSubjects;

@end

@implementation SubjectViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.arrayWithSubjects = @[@"Работа", @"Куплю", @"Продам", @"Жилье"];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.arrayWithSubjects count];
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentifire = @"cellIdentifire";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifire];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifire];
    }
    
    cell.textLabel.text = [self.arrayWithSubjects objectAtIndex:indexPath.row];
    
    return cell;
    
}

@end
