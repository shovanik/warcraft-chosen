//
//  AnnotationViewController.m
//  Chosen
//
//  Created by Kaustav Shee on 2/27/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "AnnotationViewController.h"

@interface AnnotationViewController ()

@end

@implementation AnnotationViewController


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnClosePressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didAnnonationClosePressed)]) {
        [self.delegate didAnnonationClosePressed];
    }
}
-(IBAction)btnAttackPressed:(id)sender;
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didAnnonationAttackPressedWithUser:)]) {
        [self.delegate didAnnonationAttackPressedWithUser:[self.delegate selectedUser]];
    }
}


@end
