//
//  UserLocationChangeViewController.m
//  Chosen
//
//  Created by Kaustav Shee on 3/4/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "UserLocationChangeViewController.h"
#import "WebService.h"

@interface UserLocationChangeViewController ()<UIAlertViewDelegate>
{
    IBOutlet UITextField *txtCountry;
    IBOutlet UITextField *txtState;
    IBOutlet UITextField *txtCity;
}

@end

@implementation UserLocationChangeViewController

#pragma mark
#pragma mark Initialization Method
#pragma mark

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    txtCountry.text=user.strCountryName;
    txtCity.text=user.strCityName;
    txtState.text=user.strStateName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark Helper Method
#pragma mark

-(BOOL)alertChecking
{
    if ([txtCountry.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter your country." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    if ([txtState.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter your state." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return NO;
    }
    if ([txtCity.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"PLease enter your city." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
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
        [[WebService service] callUpdateUserserviceWithUserName:@"" UserID:user.strID DateOfBirth:@"" Email:@"" Gender:@"" StateName:[txtState.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] CountryName:[txtCountry.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] CityName:[txtCity.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] Latitude:@"" Longitude:@"" WithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
            
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(locationDidUpdated)]) {
                [self.delegate locationDidUpdated];
            }
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
