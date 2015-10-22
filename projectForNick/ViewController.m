//
//  ViewController.m
//  projectForNick
//
//  Created by Andrii Zykov on 10/17/15.
//  Copyright © 2015 AndriiZykov. All rights reserved.
//

#import "ViewController.h"
#import "AZLogInViewController.h"
#import "CreateAdViewController.h"
#import "Ad.h"
#import "AdsDisplayController.h"
#import "SelectTypeOfSubjectController.h"
@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![PFUser currentUser]) {
        
        AZLogInViewController * logInViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
        
        [self presentViewController:logInViewController animated:YES completion:nil];
        
    }
    
    PFUser * user = [PFUser currentUser];
    
    
    
        PFObject * obj = [user objectForKey:@"profile_picture"];
    
    if (![obj isEqual:[NSNull null]]) {
        
        PFFile * imageFile = [user objectForKey:@"profile_picture"];
        
        NSData * dataWithImage = [imageFile getData];
        
        UIImage * image = [UIImage imageWithData:dataWithImage];
        
        self.profile_picture = image;
        
    }
    
           [self setUpPicture];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
 
    

    self.navigationController.navigationBar.topItem.title =  [NSString stringWithFormat:@"Пользователь, %@",[PFUser currentUser].username ];
    
    
}

#pragma mark - Actions
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.reuseIdentifier isEqualToString:@"logout"]) {
        
        [self logout];
        
    }
    
    if ([cell.reuseIdentifier isEqualToString:@"allAds"]) {
        
        [self showAllAds];
        
    }
    
    if ([cell.reuseIdentifier isEqualToString:@"myAds"]) {
        
        [self showMyAdsOnly];
        
    }
    
    if ([cell.reuseIdentifier isEqualToString:@"postAd"]) {
        
        [self addNewAd];
        
    }
    
    if ([cell.reuseIdentifier isEqualToString:@"postPlace"]) {
        
        [self postNewPlace];
        
    }
    
    if ([cell.reuseIdentifier isEqualToString:@"postPlace"]) {
        
        [self postNewPlace];
        
    }
    
    if ([cell.reuseIdentifier isEqualToString:@"profile_picture"]) {
        
        if (!self.profile_picture || [self.profile_picture isEqual:[UIImage imageNamed:@"no_picture.jpg"]]) {
            
            [self addProfilePicture];
            
        } else {
            
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Изменить фото" message:@"Изменить картинку" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
               
                
                
            }];
            
            UIAlertAction * getNewPhoto = [UIAlertAction actionWithTitle:@"Новыя фотография" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self addProfilePicture];
                
            }];
            
            UIAlertAction * erasePhoto = [UIAlertAction actionWithTitle:@"Удалить фото" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                PFUser * curentUser = [PFUser currentUser];
                
                [curentUser setObject:[NSNull null] forKey:@"profile_picture"];
                
                [curentUser saveInBackground];
                
                self.profile_picture = nil;
                
                self.profile_picture = [UIImage imageNamed:@"no_picture.jpg"];
                
                [self setUpPicture];
                
            }];
            
            [alertController addAction:getNewPhoto];
            
            [alertController addAction:erasePhoto];
            
            [alertController addAction:cancelAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
    }
    
}



#pragma mark - main logic

-(void) logout{
    
    [PFUser logOut];
    
    AZLogInViewController * loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
    
    [self presentViewController:loginViewController animated:YES completion:nil];
    
    
}

-(void) showMyAdsOnly {
    
    PFQuery * myQuery = [PFQuery queryWithClassName:@"Ad"];
    
    [myQuery whereKey:@"posted_by" equalTo:[PFUser currentUser]];
    
    [myQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        if (!error) {
            
            NSArray * adsArray = [Ad fetchAdsFromServerWithArray:objects];
            
            AdsDisplayController * adsDisplayViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AdDisplay"];
            
            adsDisplayViewController.arrayOfAds = adsArray;
            
            [self.navigationController pushViewController:adsDisplayViewController animated:YES];
            
        } else {
            
            NSLog(@"%@", error.localizedDescription);
            
        }
        
    }];
    
}

-(void) showAllAds {
    
    SelectTypeOfSubjectController * subjectTypeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SubjectTypeController"];
    
    subjectTypeViewController.creationOfNewAd = NO;
    
    [self.navigationController pushViewController:subjectTypeViewController animated:YES];
    
}

-(void) addNewAd {
    
    SelectTypeOfSubjectController * subjectTypeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SubjectTypeController"];
    
    subjectTypeViewController.creationOfNewAd = YES;
    
    [self.navigationController pushViewController:subjectTypeViewController animated:YES];
    
}

- (void) postNewPlace {
    
    NSLog(@"YO");
    
}

#pragma mark - Profile Picture Stuff


-(void) setUpPicture {
    
        
        if (!self.profile_picture) {
            
            self.profile_picture = [UIImage imageNamed:@"no_picture.jpg"];
            
        }
        
        self.profilePicture.image = self.profile_picture;
        
        self.profilePicture.layer.cornerRadius = 85;
        
        self.profilePicture.frame = CGRectMake(0, 0, self.profile_picture.size.width, self.profile_picture.size.height);
        
        self.profilePicture.layer.borderWidth = 3.0f;
        
        self.profilePicture.clipsToBounds = true;
    
        self.profilePicture.layer.borderColor = [UIColor clearColor].CGColor;
        
        NSLog(@"%@", self.profile_picture);
        
    
}

-(void) addProfilePicture {
    
    UIAlertController * newAlertController = [UIAlertController alertControllerWithTitle:@"Добавить фотографию" message:@"Добавить фото" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * useCameraAction = [UIAlertAction actionWithTitle:@"Сделать новый снимок" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self useCameraForProfilePicture];
        
    }];
    
    UIAlertAction * useGalary = [UIAlertAction actionWithTitle:@"Взять из галереи" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self useGalaryToPickProfilePicture];
        
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [newAlertController addAction:useCameraAction];
    
    [newAlertController addAction:useGalary];
    
    [newAlertController addAction:cancelAction];
    
    [self presentViewController:newAlertController animated:YES completion:nil];
    
    
}

-(void) useCameraForProfilePicture {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    
}

-(void) useGalaryToPickProfilePicture {
 
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{

    if (!image) {
                // not to get nil !!
        return;
        
    }
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"%@", image);
    
    
    CGFloat offset = image.size.height > image.size.width ? image.size.height - image.size.width : image.size.width - image.size.height;
    
    
    CGRect rectForCrop;
    
    if (image.size.height > image.size.width) {
        
        rectForCrop = CGRectMake(offset/2, 0, image.size.width, image.size.width);
        
    } else {
        
        rectForCrop = CGRectMake(0, offset/2 , image.size.height, image.size.height);
    }
    
    NSLog(@"%@", NSStringFromCGRect(rectForCrop));
    
    UIImage * newImage =  [self croppIngimageByImageName:image toRect:rectForCrop];
    
        CGFloat scaleIndex =  newImage.size.height/169.5;
    
    newImage = [self imageWithImage:newImage scaledToSize:CGSizeMake(newImage.size.width/scaleIndex, newImage.size.height/scaleIndex)];
    
    self.profile_picture = newImage;
    
    PFUser * user = [PFUser currentUser];
    
    NSData * data = UIImageJPEGRepresentation(newImage, 1);
    
    PFFile * file = [PFFile fileWithData:data];
    
    [user setObject:file forKey:@"profile_picture"];
    
    [user saveInBackground];
    
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
    
    [self setUpPicture];
}

#pragma mark Custom methods to change size and crop picture

- (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef scale:imageToCrop.scale orientation:imageToCrop.imageOrientation];
    CGImageRelease(imageRef);
    
    return cropped;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
