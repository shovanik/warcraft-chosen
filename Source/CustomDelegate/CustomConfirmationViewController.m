//
//  CustomConfirmationViewController.m
//  Chosen
//
//  Created by Kaustav Shee on 4/3/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "CustomConfirmationViewController.h"

@interface CustomConfirmationViewController ()

@end

@implementation CustomConfirmationViewController
@synthesize delegate,messageValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (messageValue.length>0)
    {
        [self.displayMessage setText:messageValue];
        self.displayMessage.font=[UIFont fontWithName:@"Garamond-Regular" size:17.0f];

    }
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnYesPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didYesPressed)]) {
        [self.delegate didYesPressed];
    }
}

-(IBAction)btnNoPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didNoPressed)]) {
        [self.delegate didNoPressed];
    }
}

@end
