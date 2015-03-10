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
    lblUserDetails.text=[NSString stringWithFormat:@"%@, %@, %@",user.strUserName,user.strAge,user.strGenderLong];
}
-(void)userDetailsDidChanged
{
    [self displayFromUser];
}

@end
