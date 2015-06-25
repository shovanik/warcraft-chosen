//
//  LoginViewController.m
//  Chosen
//
//  Created by appsbee on 15/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "LoginViewController.h"
#import "StepOneViewController.h"
#import "LandingViewController.h"
#import "Context.h"
#import "DataClass.h"
#import "ForgetPasswordViewController.h"


NSUserDefaults *pref;

@interface LoginViewController ()<UIAlertViewDelegate,UITextFieldDelegate>
{
    CGFloat animatedDistance;
    IBOutlet UITextField *userNameTextField;
    IBOutlet UITextField *passwordTextField;
    IBOutlet UIView *lgncontentView;
    IBOutlet UILabel *navTitle;
    IBOutlet NSLayoutConstraint * logContentViewVerticalyCenter;
}

@end

@implementation LoginViewController

#pragma mark
#pragma mark Initialization Method
#pragma mark


- (void)viewDidLoad {
    [super viewDidLoad];
    pref = [NSUserDefaults standardUserDefaults];
    
    
    if (IsIphone4) {
        navTitle.font = [UIFont fontWithName:@"LithosPro-Regular" size:17];
        //logContentViewVerticalyCenter.constant = 50;
    }else{
        navTitle.font = [UIFont fontWithName:@"LithosPro-Regular" size:30];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:@"UIKeyboardWillShowNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:@"UIKeyboardWillHideNotification"
                                               object:nil];


    userNameTextField.font = [UIFont fontWithName:@"Garamond" size:17];
    userNameTextField.font = [UIFont fontWithName:@"Garamond" size:17];
    
    UIColor *color = [UIColor colorWithRed:202.0f/255.0f green:230.0f/255.0f blue:233.0f/255.0f alpha:1.0f];
    userNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"User Name" attributes:@{NSForegroundColorAttributeName: color}];
    passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    userNameTextField.textColor = color;
    passwordTextField.textColor = color;
    
    userNameTextField.text = @"aa";
    passwordTextField.text = @"Password123";
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark
#pragma mark Keyboard Method
#pragma mark

- (void) keyboardWillShow:(NSNotification *)note {
    
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    CGFloat duration = [[[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        logContentViewVerticalyCenter.constant = 50;
    }else{
        logContentViewVerticalyCenter.constant = -12;
    }
    // commit animations
    [UIView commitAnimations];
}

- (void) keyboardWillHide:(NSNotification *)note {
    //CGFloat duration = [[[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    double hdDuration = [[[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    int curve = [[[note userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    // slide view down
    [UIView beginAnimations:@"foo" context:nil];
    [UIView setAnimationDuration:hdDuration];
    [UIView setAnimationCurve:curve];
    logContentViewVerticalyCenter.constant = -12;
    
    [UIView commitAnimations];
    
    
}

#pragma mark
#pragma mark UITextField Delegate
#pragma mark

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark
#pragma mark Location Manager Delegate
#pragma mark

-(void)didUpdateLocationUpdateWithPlacemark:(CLPlacemark *)placeMark
{
    NSDictionary *dict=[self addressDictionaryForPlaceMark:placeMark];
    NSLog(@"Latitude = %@",[dict objectForKey:@"Latitude"]);
    NSLog(@"Longitude = %@",[dict objectForKey:@"Longitude"]);
    [[WebService service] callLoginServiceWithUserName:[userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] Password:[passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] Latitude:[dict objectForKey:@"Latitude"] Longitude:[dict objectForKey:@"Longitude"] WithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
        if (isError) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:strMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }else{
            
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSMutableDictionary *dict=(NSMutableDictionary*)result;
                
                id tempUser=[dict objectForKey:@"User"];
                if ([tempUser isKindOfClass:[ModelUser class]]) {
                    user=(ModelUser*)tempUser;
                    [slideMenu setAvtarImageForURL:[NSURL URLWithString:user.strDefaultImageURL]];
                }
                id tempAllUser=[dict objectForKey:@"AllUser"];
                if ([tempAllUser isKindOfClass:[NSMutableArray class]]) {
                    allUser=(NSMutableArray*)tempAllUser;
                }
                stringUserID=user.strID;
                //[[OnlineOfflineTrackerManager manager] startTrackingUserForUserID:user.strID];
            }
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Success" message:strMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag=1;
            [alert show];
        }
        [self.activityIndicatorView stopAnimating];
        [self.view setUserInteractionEnabled:YES];
    }];
}

#pragma mark
#pragma mark IBAction
#pragma mark

-(IBAction)loginButtonTapped:(id)sender
{
    if (self.isNetworkRechable) {
        [self startLocationManager];
        [self.activityIndicatorView startAnimating];
        [self.view setUserInteractionEnabled:NO];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"Error" message:__kNetworkUnavailableMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

-(IBAction)btnForgetPasswordTapped:(id)sender
{
    ForgetPasswordViewController *master=[[ForgetPasswordViewController alloc] initWithNibName:@"ForgetPasswordViewController" bundle:nil];
    [self presentViewController:master animated:YES completion:^{
        
    }];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        
        [self makeSocketConnectionWithUser:user];
        
        StepOneViewController *sVC  = [[StepOneViewController alloc] initWithNibName:@"StepOneViewController" bundle:nil];
        [self.navigationController pushViewController:sVC animated:YES];
    }
}
@end
