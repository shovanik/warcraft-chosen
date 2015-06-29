//
//  PrivatePublicConfirmationViewController.m
//  Chosen
//
//  Created by Kaustav Shee on 6/26/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "PrivatePublicConfirmationViewController.h"

@interface PrivatePublicConfirmationViewController ()

@end

@implementation PrivatePublicConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnPublicPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didPublicPressed)]) {
        [self.delegate didPublicPressed];
    }
}

-(IBAction)btnPrivatePressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didPrivatePressed)]) {
        [self.delegate didPrivatePressed];
    }
}

@end
