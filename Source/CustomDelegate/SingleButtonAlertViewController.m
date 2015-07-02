//
//  SingleButtonAlertViewController.m
//  Chosen
//
//  Created by Kaustav Shee on 6/30/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "SingleButtonAlertViewController.h"

@interface SingleButtonAlertViewController ()
{
    IBOutlet UILabel *lblMessageBody;
    IBOutlet UIButton *btn;
}

@end

@implementation SingleButtonAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(SingleButtonAlertViewController*)sharedInstance
{
    static SingleButtonAlertViewController *singleButtonAlert=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleButtonAlert=[[SingleButtonAlertViewController alloc] initWithNibName:@"SingleButtonAlertViewController" bundle:nil];
    });
    return singleButtonAlert;
}

-(void)displayMessageWithMessageBody:(NSString *)strMessageBody ButtonTitle:(NSString*)strBtnTitle Delegate:(id<SingleButtonDelegate>)delegate
{
    lblMessageBody.text=strMessageBody;
    [btn setTitle:strBtnTitle forState:UIControlStateNormal];
    self.delegate=delegate;
}

-(IBAction)btnPresed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didOkPressed)]) {
        [self.delegate didOkPressed];
    }
}


@end
