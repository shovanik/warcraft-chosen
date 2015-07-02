//
//  MyProfileViewController.m
//  Chosen
//
//  Created by Kaustav Shee on 3/4/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "MyProfileViewController.h"
#import "AvatarSelectionViewController.h"
#import "UserPasswordChangeViewController.h"
#import "UserLocationChangeViewController.h"
#import "UserDetailsChangeViewController.h"

@interface MyProfileViewController ()<AvatarSelectionControllerDelegate,UserLocationChangeViewControllerDelegate,UserDetailsChangeViewControllerDelegate>
{
    IBOutlet UIImageView *img;
    IBOutlet UILabel *lblUserDetails;
    IBOutlet UILabel *lblLocationDetails;
}

@end

@implementation MyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self displayFromUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnChangeAvatarPressed:(id)sender
{
    AvatarSelectionViewController *master=[[AvatarSelectionViewController alloc] initWithNibName:@"AvatarSelectionViewController" bundle:nil];
    master.delegate=self;
    [self presentViewController:master animated:YES completion:^{
        
    }];
}

-(IBAction)btnChangePasswordPressed:(id)sender
{
    UserPasswordChangeViewController *master=[[UserPasswordChangeViewController alloc] initWithNibName:@"UserPasswordChangeViewController" bundle:nil];
    [self presentViewController:master animated:YES completion:^{
        
    }];
}

-(IBAction)btnChangeLocationPressed:(id)sender
{
    UserLocationChangeViewController *master=[[UserLocationChangeViewController alloc] initWithNibName:@"UserLocationChangeViewController" bundle:nil];
    master.delegate=self;
    [self presentViewController:master animated:YES completion:^{
        
    }];
}

-(IBAction)btnChangeUserDetailsPressed:(id)sender
{
    UserDetailsChangeViewController *master=[[UserDetailsChangeViewController alloc] initWithNibName:@"UserDetailsChangeViewController" bundle:nil Delegate:self];
    [self presentViewController:master animated:YES completion:^{
        
    }];
}

-(void)selectedAvatar:(UIImage *)image
{
    img.image=image;
}

-(void)locationDidUpdated
{
    [self displayFromUser];
}

-(void)displayFromUser
{
    lblLocationDetails.text=[NSString stringWithFormat:@"%@, %@, %@",user.strCountryName,user.strStateName,user.strCityName];
    NSDate *myDate=[NSDate dateWithTimeIntervalSince1970:[user.strDateOfBirth longLongValue]];
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:myDate
                                       toDate:[NSDate date]
                                       options:0];
    lblUserDetails.text=[NSString stringWithFormat:@"%@, %ld, %@",user.strUserName,(long)[ageComponents year],user.strGenderLong];
}
-(void)userDetailsDidChanged
{
    [self displayFromUser];
}

@end
