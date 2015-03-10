//
//  AvatarSelectionViewController.m
//  Chosen
//
//  Created by Kaustav Shee on 3/4/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "AvatarSelectionViewController.h"

@interface AvatarSelectionViewController ()
{
    NSMutableArray *arrImages;
    
    IBOutlet UIScrollView *myScrollView;
//    IBOutlet UIImageView *img;
//    IBOutlet UIButton *btn;
}

@end

@implementation AvatarSelectionViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    arrImages=[NSMutableArray arrayWithObjects:@"avatar_1.png",@"avatar_2.png",@"avatar_3.png",@"Avatar_pic.png", nil];
    
    [self initializeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initializeView
{
    myScrollView.frame=CGRectMake(myScrollView.frame.origin.x, myScrollView.frame.origin.y, [[UIScreen mainScreen] bounds].size.width-myScrollView.frame.origin.x, [[UIScreen mainScreen] bounds].size.height-myScrollView.frame.origin.y-10);
    myScrollView.contentSize=CGSizeMake(myScrollView.frame.size.width*arrImages.count, myScrollView.frame.size.height);
    for (int i=0; i<arrImages.count; i++) {
        UIButton *btnn=[[UIButton alloc] initWithFrame:CGRectMake(myScrollView.frame.size.width*i+40, 0, myScrollView.frame.size.width-40, myScrollView.frame.size.height)];
        [btnn setClipsToBounds:YES];
        //[btnn setBackgroundImage:[UIImage imageNamed:[arrImages objectAtIndex:i]] forState:UIControlStateNormal];
        [btnn setImage:[UIImage imageNamed:[arrImages objectAtIndex:i]] forState:UIControlStateNormal];
        btnn.tag=i;
        [btnn addTarget:self action:@selector(btnAvatarTapped:) forControlEvents:UIControlEventTouchUpInside];
        [myScrollView addSubview:btnn];
    }
}

-(IBAction)btnAvatarTapped:(id)sender
{
    NSLog(@"sender tag = %ld",(long)[sender tag]);
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedAvatar:)]) {
        [self.delegate selectedAvatar:[UIImage imageNamed:[arrImages objectAtIndex:[sender tag]]]];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
