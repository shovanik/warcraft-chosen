//
//  CustomDatePickerViewController.h
//  Chosen
//
//  Created by Kaustav Shee on 3/6/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomDatePickerViewControllerDelegate <NSObject>

@optional

-(void)datePickerPickedDate:(NSDate*)selectedDate;
-(void)datePickerCancelPressed;

@end

@interface CustomDatePickerViewController : UIViewController

@property(weak,nonatomic) id <CustomDatePickerViewControllerDelegate> delegate;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil MaxDate:(NSDate*)dateMax MinDate:(NSDate*)dateMin Delegate:(id)delegate;

@end
