//
//  ForgetPasswordViewController.m
//  Chosen
//
//  Created by Kaustav Shee on 3/6/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()<UIAlertViewDelegate>
{
    IBOutlet UITextField *txtEmail;
}

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(IBAction)btnSubmitPressed:(id)sender
{
    if ([txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter the email id." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }else{
        [[WebService service] callForgetPasswordServiceForEmailID:[txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] withCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
            if (isError) {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:strMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag=1;
                [alert show];
            }else{
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Success" message:strMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag=2;
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

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    if (alertView.tag==2) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

@end
