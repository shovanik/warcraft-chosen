//
//  UserPasswordChangeViewController.m
//  Chosen
//
//  Created by Kaustav Shee on 3/4/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "UserPasswordChangeViewController.h"
#import "WebService.h"

@interface UserPasswordChangeViewController ()<UIAlertViewDelegate,UITextFieldDelegate>
{
    IBOutlet UITextField *txtOldPassword;
    IBOutlet UITextField *txtNewPassword;
    IBOutlet UITextField *txtConfirmPassword;
}

@end

@implementation UserPasswordChangeViewController

#pragma mark
#pragma mark Initialization Method
#pragma mark


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark
#pragma mark Supporting Method
#pragma mark

-(BOOL)alertChecking
{
    if ([txtOldPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter the old password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return NO;
    }
    if ([txtNewPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter the new password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return NO;
    }
    if ([txtConfirmPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter the confirm password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return NO;
    }
    if (![txtNewPassword.text isEqualToString:txtConfirmPassword.text]) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"New Password and Confirm Password should be same." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return NO;
    }
    return YES;
}
#pragma mark
#pragma mark IBAction Method
#pragma mark

-(IBAction)btnSubmitPressed:(id)sender
{
    if ([self alertChecking]) {
        [[WebService service] callResetPasswordServiceForUserID:user.strID NewPassword:txtNewPassword.text OldPassword:txtOldPassword.text WithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
            if (isError) {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:strMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag=1;
                [alert show];
            }else{
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Success" message:strMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag=1;
                [alert show];
            }
        }];
    }
}

-(IBAction)btnCancelPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark
#pragma mark AlertView Delegate Method
#pragma mark

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
#pragma mark
#pragma mark TextField Delegate Method
#pragma mark

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.frame.origin.y>150) {
        [UIView animateWithDuration:0.5 animations:^{
            self.view.frame=CGRectMake(0, self.view.frame.origin.y-100, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

@end
