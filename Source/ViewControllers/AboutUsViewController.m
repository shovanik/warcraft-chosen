//
//  AboutUsViewController.m
//  Chosen
//
//  Created by Kaustav Shee on 3/4/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
{
    IBOutlet UITextView *txtDisplay;
    IBOutlet UILabel *lblHeading;
    ModelAboutUs *objAboutUs;
    ModelPrivacyPolicy *objPrivacyPolicy;
    ModelTerms *objTerms;
}

@end

@implementation AboutUsViewController

#pragma mark
#pragma mark Initialization Method
#pragma mark

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.activityIndicatorView startAnimating];
    
    if ([_strFor isEqualToString:@"aboutus"]) {
        [self loadAPIDataForAboutUS];
        lblHeading.text=@"ABOUT US";
    }
    else if ([_strFor isEqualToString:@"terms"]){
        [self loadAPIDataForTermsAndCondition];
        lblHeading.text=@"TERMS & CONDITION";
    }
    else if ([_strFor isEqualToString:@"privacy"]){
        [self loadAPIDataForPrivacyPolicy];
        lblHeading.text=@"PRIVACY POLICY";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark
#pragma mark Data Loading Method
#pragma mark

-(void)loadAPIDataForAboutUS
{
    [[WebService service] callAboutUsServiceWithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
        if (isError) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Something is wrong, please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag=1;
            [alert show];
        }else{
            if ([result isKindOfClass:[ModelAboutUs class]]) {
                objAboutUs=(ModelAboutUs*)result;
                txtDisplay.text=objAboutUs.strLongDescription;
            }
        }
        [self.activityIndicatorView stopAnimating];
    }];
}
-(void)loadAPIDataForPrivacyPolicy
{
    [[WebService service] callPrivacyPolicyWithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
        if (isError) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Something is wrong, please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag=1;
            [alert show];
        }else{
            if ([result isKindOfClass:[ModelPrivacyPolicy class]]) {
                objPrivacyPolicy=(ModelPrivacyPolicy*)result;
                txtDisplay.text=objPrivacyPolicy.strLongDescription;
            }
        }
        [self.activityIndicatorView stopAnimating];
    }];
}
-(void)loadAPIDataForTermsAndCondition
{
    [[WebService service] callTermsAndConditionWithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
        if (isError) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Something is wrong, please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag=1;
            [alert show];
        }else{
            if ([result isKindOfClass:[ModelTerms class]]) {
                objTerms=(ModelTerms*)result;
                txtDisplay.text=objTerms.strLongDescription;
            }
        }
        [self.activityIndicatorView stopAnimating];
    }];
}

@end
