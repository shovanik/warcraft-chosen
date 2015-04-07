//
//  AttackViewController.m
//  Chosen
//
//  Created by Kaustav Shee on 4/3/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "AttackViewController.h"
#import "GuildImageView.h"
#import "ImageTouchDetection.h"
#import "ImageViewExplotion.h"

@interface AttackViewController ()<ImageTouchDetectionDelegate>
{
    IBOutlet GuildImageView *imgSliderOwn;
    IBOutlet GuildImageView *imgSliderRival;
    IBOutlet ImageTouchDetection *imgMain;
    
    
    IBOutlet UIImageView *imgTimer;
}

@end

@implementation AttackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [imgSliderOwn setSliderColor:[UIColor blueColor]];
    [imgSliderRival setSliderColor:[UIColor redColor]];
    
    [imgSliderOwn setPercentage:85];
    [imgSliderRival setPercentage:45];
    
    
    NSMutableArray *arrImages=[[NSMutableArray alloc] init];
    for (int i=1; i<=20; i++) {
        [arrImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]]];
    }
    
    imgTimer.animationImages=arrImages;
    imgTimer.animationDuration=1.5;
    imgTimer.animationRepeatCount=0;
    [imgTimer startAnimating];
    
    imgMain.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didClickedBlankPortion
{
    NSLog(@"Blank");
}

-(void)didClickedOnImageWithLocation:(CGPoint)touchLocation RGB:(UIColor *)color Alpha:(CGFloat)alpha
{
    NSLog(@"Contained");
    if (alpha>50) {
        NSLog(@"Body");
        
        
        NSThread *myThread=[[NSThread alloc] initWithTarget:self selector:@selector(threadMethodOnPoint:) object:NSStringFromCGPoint(touchLocation)];
        [myThread start];
        
        //[self threadMethodOnPoint:NSStringFromCGPoint(touchLocation)];
        
    }else{
        NSLog(@"Background");
    }
}

-(void)threadMethodOnPoint:(NSString*)strPoint
{
    
    NSLog(@"Point = %@",strPoint);
    CGPoint touchPoint=CGPointFromString(strPoint);
    ImageViewExplotion *imgExplotion=[[ImageViewExplotion alloc] initWithFrame:CGRectMake(touchPoint.x-15, touchPoint.y-15, 30, 30)];
    NSLog(@"Point = %@",NSStringFromCGRect(imgExplotion.frame));
    NSLog(@"Point = %@",NSStringFromCGRect(imgMain.frame));
    [imgExplotion setImage:[UIImage imageNamed:@"color.png"]];
    [imgMain addSubview:imgExplotion];
    
    
    imgExplotion.animationImages=[NSArray arrayWithObjects:
                                  [UIImage imageNamed:@"target1.png"],
                                  [UIImage imageNamed:@"target2.png"],
                                  [UIImage imageNamed:@"target3.png"],
                                  [UIImage imageNamed:@"target4.png"],
                                  nil];
    imgExplotion.animationDuration=0.5;
    imgExplotion.animationRepeatCount=0;
    [imgExplotion startAnimating];
    //    while (1) {
    //        //            if ([[NSDate date] timeIntervalSinceDate:imgExplotion.dateStartTime]>=10) {
    //        //                [imgExplotion stopAnimating];
    //        //                break;
    //        //            }
    //    }
}

@end
