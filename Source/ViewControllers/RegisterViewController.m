//
//  RegisterViewController.m
//  Chosen
//
//  Created by appsbee on 17/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "RegisterViewController.h"
#import "Context.h"
#import "StepOneViewController.h"
#import "LandingViewController.h"
#import "DataClass.h"
#import "SettingsViewController.h"

NSUserDefaults *pref;

@interface RegisterViewController () <UITextFieldDelegate,UIAlertViewDelegate>
{
    IBOutlet UIView *regContentView;
    IBOutlet UILabel *navTitle;
    IBOutlet UITextField *txtUserName;
    IBOutlet UITextField *txtPassword;
    IBOutlet UITextField *txtConfirmPassword;
    IBOutlet UITextField *txtDOB;
    IBOutlet UITextField *txtEmail;
    IBOutlet UIButton *btnMale;
    IBOutlet UIButton *btnFemale;
    IBOutlet NSLayoutConstraint * regContentViewVerticalyCenter;
    IBOutlet UIButton *btnSubmit;

    UIDatePicker *dateatePickerView;
    UIView *datePickerEditView;
    CGFloat animatedDistance;
    CGFloat duration;
    CGRect keyboardBounds;
    CGRect actuallRect ;
    NSString *genderString;
    
    
    CGRect prevFrame;
}


@end

@implementation RegisterViewController


#pragma mark
#pragma mark Initialization Method
#pragma mark


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    pref = [NSUserDefaults standardUserDefaults];

    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        // NSLog(@"iPhone4");
        navTitle.font = [UIFont fontWithName:@"LithosPro-Regular" size:17];
        
    }else{
        navTitle.font = [UIFont fontWithName:@"LithosPro-Regular" size:30];
        
        //  NSLog(@"iPhone6");
        
    }

    
    UIColor *color = [UIColor colorWithRed:202.0f/255.0f green:230.0f/255.0f blue:233.0f/255.0f alpha:1.0f];
    txtUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"User Name" attributes:@{NSForegroundColorAttributeName: color}];
    txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    txtConfirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"conform Password" attributes:@{NSForegroundColorAttributeName: color}];
    txtDOB.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Dat of Birth" attributes:@{NSForegroundColorAttributeName: color}];
    txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-mail" attributes:@{NSForegroundColorAttributeName: color}];
    txtUserName.textColor = color;
    txtPassword.textColor = color;
    txtConfirmPassword.textColor = color;
    txtDOB.textColor = color;
    txtEmail.textColor = color;
    
    
    if (dateatePickerView == nil) {
        UIDatePicker * aPick = nil;
        
        if (IsIphone4)
        {
            aPick  = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 264, 320, 216)];

        }
        else if (IsIphone5)
        {
            aPick  = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 352, 320, 216)];

        }
        else if (IsIphone6)
        {
            // Iphone 6
            aPick  = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 451, 375, 216)];

        }else{
            aPick  = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 520, 414, 216)];

        }
        
        [aPick setDatePickerMode:UIDatePickerModeDate];
        [aPick setMaximumDate:[NSDate date]];
        [aPick addTarget:self action:@selector(dateLabelChanged:) forControlEvents:UIControlEventValueChanged];
        dateatePickerView = aPick;
    }

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:@"UIKeyboardWillShowNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:@"UIKeyboardWillHideNotification"
                                               object:nil];


    
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark UITextField Delegate Method
#pragma mark

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
}
- (void) keyboardWillShow:(NSNotification *)note {
    // get keyboard size and loctaion
    
    
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    //NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    duration = [[[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    NSLog(@"%f",keyboardBounds.size.height);
    
    // get a rect for the textView frame
    CGRect containerFrame = regContentView.frame;
    actuallRect = regContentView.frame;
    NSLog(@"login content view frame = %f  %f",containerFrame.origin.y , containerFrame.size.height);
    
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + regContentView.frame.size.height);
    
    NSLog(@"login content view frame = %f  %f",containerFrame.origin.y , containerFrame.size.height);
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        regContentViewVerticalyCenter.constant = 100;
    }else{
        regContentViewVerticalyCenter.constant = 130;
    }

    regContentView.frame = containerFrame;
    
    
    // commit animations
    [UIView commitAnimations];
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [textField resignFirstResponder];
    return YES;
}

- (void) keyboardWillHide:(NSNotification *)note {
    duration = [[[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    double hdDuration = [[[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    int curve = [[[note userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    // slide view down
    [UIView beginAnimations:@"foo" context:nil];
    [UIView setAnimationDuration:hdDuration];
    [UIView setAnimationCurve:curve];
    regContentView.frame = actuallRect ;
    regContentViewVerticalyCenter.constant = 0;

    [UIView commitAnimations];
    
    
}
#pragma mark
#pragma mark IBAction Method
#pragma mark

-(IBAction)maleFemaleButtonTapped:(id)sender{
    
    if (sender == btnMale)
    {
        btnMale.selected = YES;
        btnFemale.selected = NO;
        genderString = @"1";
    }else if (sender == btnFemale){
        btnMale.selected = NO;
        btnFemale.selected = YES;
        genderString = @"2";

    }
   // NSLog(@"Gender = %@", genderString);
    
    
}
-(IBAction)submitButtonTapped:(id)sender
{
    if (txtUserName.text.length == 0 || txtPassword.text.length == 0 || genderString.length == 0 || txtDOB == 0 || txtEmail.text.length == 0 )
    {
        [self alertStatus:@"All Fields are mandatory." :@"Registration Failed!"];
    }
    else
    {
        if(![self NSStringIsValidPassword:[txtPassword text]])
        {
            //[self alertStatus:@"Your password must contain at least one numeric number or one special character." :@"Registration Failed!"];
        }
        else if (![txtPassword.text isEqualToString:txtConfirmPassword.text]) {
            
            [self alertStatus:@"The password entered does not match the confirmation password." :@"Registration Failed!"];
        }
        else if(![self NSStringIsValidEmail:[txtEmail text]])
        {
            [self alertStatus:@"Please enter valid Email ID" :@"Registration Failed!"];
        }
        else
        {
            [self.view setUserInteractionEnabled:NO];
            [self.activityIndicatorView startAnimating];
            [self startLocationManager];
        }
    }
}
-(IBAction)dobButtonClicked:(id)sender;
{
    //[self.currentTextFieldResponder resignFirstResponder];
    
    //  self.seletedDateButtonString = START_DATE_BUTTON_CLICKED_KEY;
    
    
    
    [self launchDatePicker];
    
    [self.view endEditing:YES];
    
    prevFrame=regContentView.frame;
    [UIView animateWithDuration:0.2 animations:^{
        regContentViewVerticalyCenter.constant=120.0f;
    } completion:^(BOOL finished) {
        
    }];
    
    if ((txtDOB.text == nil) || ([txtDOB.text length] <= 0)) {
        
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd"];
        
        NSString *formattedDateString  = [df stringFromDate:[NSDate date]];
        txtDOB.text = formattedDateString;
    }
    
}
#pragma mark
#pragma mark Helper Method
#pragma mark

- (void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}
#pragma mark
#pragma mark Validation Checking Method
#pragma mark

-(BOOL) NSStringIsValidPassword:(NSString *)checkString
{
    BOOL digit = false;
    if([checkString length] >= 8)
    {
        
        for (int i = 0; i < [checkString length]; i++)
        {
            unichar c = [checkString characterAtIndex:i];
            if(!digit)
            {
                digit = [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:c];
            }

        }
        if (digit) {
            return YES;

        }else{
            [self alertStatus:@"Your password must contain at least one number and one upper or lowercase letter" :@"Registration Failed!"];

        }
    }
    else
    {
        [self alertStatus:@"Your password must be 8 characters long." :@"Registration Failed!"];
    }
    
    return NO;
}


-(void)launchDatePicker
{
    
    if (datePickerEditView == nil)
    {
        NSLog(@"viewFrame:%f,%f",self.view.frame.origin.x, self.view.frame.origin.y);
        UIView * uv = [[UIView alloc] initWithFrame:self.view.frame];
        NSLog(@"ed vi y:%f, h = %f",uv.frame.origin.y,uv.frame.size.height);

        uv.backgroundColor = [UIColor clearColor];
        datePickerEditView = uv;
        
        UIToolbar *assignmentStartToolBar =  nil;
        
        if (IsIphone4)
        {
            assignmentStartToolBar  = [[UIToolbar alloc] initWithFrame:CGRectMake(0,220,320,44)];
            
        }
        else if (IsIphone5)
        {
            assignmentStartToolBar  = [[UIToolbar alloc] initWithFrame:CGRectMake(0,308,320,44)];
            
        }
        else if (IsIphone6)
        {
            // Iphone 6
            assignmentStartToolBar  = [[UIToolbar alloc] initWithFrame:CGRectMake(0,407,375,44)];
            
        }else{
            assignmentStartToolBar  = [[UIToolbar alloc] initWithFrame:CGRectMake(0,476,414,44)];
            
        }
        [assignmentStartToolBar setBarStyle:UIBarStyleBlackOpaque];
        assignmentStartToolBar.tintColor = [UIColor blackColor];
        dateatePickerView.backgroundColor = [UIColor whiteColor];
        
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(assignmentStartDateDoneButtonTapped)];
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        assignmentStartToolBar.items = [NSArray arrayWithObjects:flex, barButtonDone,nil];
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        barButtonDone.tintColor=[UIColor whiteColor];
#endif
        
        [datePickerEditView addSubview:dateatePickerView];
        [datePickerEditView addSubview:assignmentStartToolBar];
        NSLog(@"ed vi y:%f, h = %f",dateatePickerView.frame.origin.y,dateatePickerView.frame.size.height);
    }
    
    [self.view addSubview:datePickerEditView];
}
-(void)dateLabelChanged:(id)sender{
    NSDate *date = dateatePickerView.date;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *formattedDateString = [df stringFromDate:date];
    txtDOB.text = formattedDateString;
    
    NSLog(@"Dob = %@", txtDOB.text);
    
}
-(void)assignmentStartDateDoneButtonTapped{
    [UIView animateWithDuration:0.2 animations:^{
        regContentViewVerticalyCenter.constant=0.0f;
    } completion:^(BOOL finished) {
        
    }];
    [datePickerEditView removeFromSuperview];
}

#pragma mark
#pragma mark Location Manager Delegate
#pragma mark

-(void)didUpdateLocationUpdateWithPlacemark:(CLPlacemark *)placeMark
{
    if (self.isNetworkRechable) {
        NSDictionary *dict=[self addressDictionaryForPlaceMark:placeMark];
        
        NSLog(@"Latitude = %@",[dict objectForKey:@"Latitude"]);
        NSLog(@"Longitude = %@",[dict objectForKey:@"Longitude"]);
        
        [[WebService service] callRegistrationServiceWithUserName:[txtUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] Password:[txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] DateOfBirth:[txtDOB.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] Email:[txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] Gender:[genderString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] StateName:[dict objectForKey:@"State"] CountryName:[dict objectForKey:@"Country"] CityName:[dict objectForKey:@"City"] Latitude:[dict objectForKey:@"Latitude"] Longitude:[dict objectForKey:@"Longitude"] WithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
            if (isError) {
                [[[UIAlertView alloc] initWithTitle:@"Error" message:strMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            }else{
                if ([result isKindOfClass:[NSDictionary class]]) {
                    NSMutableDictionary *dict=(NSMutableDictionary*)result;
                    
                    id tempUser=[dict objectForKey:@"User"];
                    if ([tempUser isKindOfClass:[ModelUser class]]) {
                        user=(ModelUser*)tempUser;
                    }
                    id tempAllUser=[dict objectForKey:@"AllUser"];
                    if ([tempAllUser isKindOfClass:[NSMutableArray class]]) {
                        allUser=(NSMutableArray*)tempAllUser;
                    }
                }
                
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Success" message:strMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag=1;
                [alert show];
            }
            [self.view setUserInteractionEnabled:YES];
            [self.activityIndicatorView stopAnimating];
        }];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"Error" message:__kNetworkUnavailableMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    
}

#pragma mark
#pragma mark UIAlertView Delegate Method
#pragma mark

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        StepOneViewController *master=[[StepOneViewController alloc] initWithNibName:@"StepOneViewController" bundle:nil];
        [self.navigationController pushViewController:master animated:YES];
    }
}


@end
