//
//  UserDetailsChangeViewController.m
//  Chosen
//
//  Created by Kaustav Shee on 3/4/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "UserDetailsChangeViewController.h"
#import "CustomDatePickerViewController.h"
#import "WebService.h"

@interface UserDetailsChangeViewController ()<CustomDatePickerViewControllerDelegate>
{
    IBOutlet UITextField *txtUserName;
    IBOutlet UITextField *txtDateOfBirth;
    IBOutlet UIButton *btnMale;
    IBOutlet UIButton *btnFemale;
    
    CustomDatePickerViewController *master;
    NSString *strGender;
}

@end

@implementation UserDetailsChangeViewController
#pragma mark
#pragma mark Initialization Method
#pragma mark

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Delegate:(id)delegate
{
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _delegate=delegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    txtUserName.text=user.strUserName;
    txtDateOfBirth.text=user.strDateOfBirth;
    
    
    master=[[CustomDatePickerViewController alloc] initWithNibName:@"CustomDatePickerViewController" bundle:nil MaxDate:[NSDate date] MinDate:nil Delegate:self];
    master.view.frame=self.view.frame;
    [self.view addSubview:master.view];
    [master.view setHidden:YES];
    
    strGender=nil;
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
    if (textField==txtDateOfBirth) {
        [self.view endEditing:YES];
        [textField resignFirstResponder];
        [master.view setHidden:NO];
    }else{
        if (textField.frame.origin.y>150) {
            [UIView animateWithDuration:0.5 animations:^{
                self.view.frame=CGRectMake(0, self.view.frame.origin.y-100, self.view.frame.size.width, self.view.frame.size.height);
            }];
        }
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

#pragma mark
#pragma mark CustomDatePickerViewControllerDelegate Delegate Method
#pragma mark

-(void)datePickerPickedDate:(NSDate *)selectedDate
{
    txtDateOfBirth.text=[dateFormattter stringFromDate:selectedDate];
    master.view.hidden=YES;
}
-(void)datePickerCancelPressed
{
    master.view.hidden=YES;
}

#pragma mark
#pragma mark IBAction Method
#pragma mark

-(IBAction)btnMalePressed:(id)sender
{
    strGender=@"M";
}
-(IBAction)btnFemalePressed:(id)sender
{
    strGender=@"F";
}

-(IBAction)btnSubmitPressed:(id)sender
{
    if ([self alertChecking]) {
        [[WebService service] callUpdateUserserviceWithUserName:[txtUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] UserID:user.strID DateOfBirth:[txtDateOfBirth.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] Email:@"" Gender:strGender StateName:@"" CountryName:@"" CityName:@"" Latitude:@"" Longitude:@"" WithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
            if (isError) {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:strMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                alert.tag=1;
                [alert show];
            }else{
                if ([result isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dict=(NSDictionary*)result;
                    user=[dict objectForKey:@"User"];
                    allUser=[dict objectForKey:@"AllUser"];
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Your location is updated successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    alert.tag=2;
                    [alert show];
                }
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
#pragma mark Helper Method
#pragma mark

-(BOOL)alertChecking
{
    if ([txtUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter the user name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return NO;
    }
    if ([txtDateOfBirth.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter the date of birth." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return NO;
    }
    if (!strGender) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter the gender." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return NO;
    }
    return YES;
}
#pragma mark
#pragma mark UIAlertView Delegate Method
#pragma mark

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    if (alertView.tag==2) {
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.delegate && [self.delegate respondsToSelector:@selector(userDetailsDidChanged)]) {
                [self.delegate userDetailsDidChanged];
            }
        }];
    }
}

@end
