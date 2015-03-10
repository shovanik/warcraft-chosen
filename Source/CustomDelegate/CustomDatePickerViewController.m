//
//  CustomDatePickerViewController.m
//  Chosen
//
//  Created by Kaustav Shee on 3/6/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "CustomDatePickerViewController.h"

@interface CustomDatePickerViewController ()
{
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIButton *btnDone;
    IBOutlet UIButton *btnCancel;
    
    NSDate *myMaxdate;
    NSDate *myMinDate;
}

@end

@implementation CustomDatePickerViewController

#pragma mark
#pragma mark Initialization Method
#pragma mark

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil MaxDate:(NSDate*)dateMax MinDate:(NSDate*)dateMin Delegate:(id)delegate
{
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [datePicker setDatePickerMode:UIDatePickerModeDate];
        if (dateMax) {
            [datePicker setMaximumDate:dateMax];
            myMaxdate=dateMax;
        }
        if (dateMin) {
            myMinDate=dateMin;
            [datePicker setMinimumDate:dateMin];
        }
        if (delegate) {
            _delegate=delegate;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (myMaxdate) {
        [datePicker setMaximumDate:myMaxdate];
    }
    if (myMinDate) {
        [datePicker setMinimumDate:myMinDate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark
#pragma mark IBAction Method
#pragma mark

-(IBAction)btnDonePressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerPickedDate:)]) {
        [self.delegate datePickerPickedDate:datePicker.date];
    }
}

-(IBAction)btnCancelPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerCancelPressed)]) {
        [self.delegate datePickerCancelPressed];
    }
}



@end
