//
//  ImageTouchDetection.m
//  ColorPickerFromImage
//
//  Created by Kaustav Shee on 3/31/15.
//  Copyright (c) 2015 AppsBee. All rights reserved.
//

#import "ImageTouchDetection.h"
#import "ImageViewExplotion.h"

@interface ImageTouchDetection ()
{
    ImageViewExplotion *imgExplotion;
    ImageViewExplotion *imgExplotionOponents;
}

@end

@implementation ImageTouchDetection

-(id)init
{
    if (self=[super init]) {
        [self initialize];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

-(id)initWithImage:(UIImage *)image
{
    if (self=[super initWithImage:image]) {
        [self initialize];
    }
    return self;
}

-(id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    if (self=[super initWithImage:image highlightedImage:highlightedImage]) {
        [self initialize];
    }
    return self;
}



-(void)initialize
{
    imgExplotion=[[ImageViewExplotion alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    imgExplotion.animationImages=[NSArray arrayWithObjects:
                                  [UIImage imageNamed:@"target1.png"],
                                  [UIImage imageNamed:@"target2.png"],
                                  [UIImage imageNamed:@"target3.png"],
                                  [UIImage imageNamed:@"target4.png"],
                                  nil];
    imgExplotion.animationDuration=0.7;
    imgExplotion.animationRepeatCount=0;
    //imgExplotion.backgroundColor=[UIColor redColor];
    
    imgExplotionOponents=[[ImageViewExplotion alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    imgExplotionOponents.animationImages=[NSArray arrayWithObjects:
                                          [UIImage imageNamed:@"r1.png"],
                                          [UIImage imageNamed:@"r2.png"],
                                          [UIImage imageNamed:@"r3.png"],
                                          [UIImage imageNamed:@"r4.png"],
                                          [UIImage imageNamed:@"r5.png"],
                                          nil];
    imgExplotionOponents.animationDuration=0.7;
    imgExplotionOponents.animationRepeatCount=0;
    
    
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    [self addGestureRecognizer:tapRecognizer];
    self.userInteractionEnabled = YES;
}

-(void)startAnimatorOwn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didAnimationStartedOwn)]) {
        [self animator];
        [self.delegate didAnimationStartedOwn];
    }
}
-(void)animator
{
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    
    int bpr =(int) CGBitmapContextGetBytesPerRow(context);
    unsigned char * data = CGBitmapContextGetData(context);
    
    while (1)
    {
        int randomX = arc4random()%(u_int32_t)self.frame.size.width;
        int randomY = arc4random()%(u_int32_t)self.frame.size.height;
        CGPoint myPoint=CGPointMake(randomX, randomY);
        
        int offset = bpr*round(myPoint.y) + 4*round(myPoint.x);
        int blue = data[offset+0];
        int green = data[offset+1];
        int red = data[offset+2];
        int alpha =  data[offset+3];
        
        CGFloat derivedAlpha=alpha/255.0f;
        
        NSLog(@"%d %d %d %d %f", alpha, red, green, blue,derivedAlpha);
        if (alpha > 0)
        {
            imgExplotion.center =myPoint;
            [self addSubview:imgExplotion];
            [imgExplotion startAnimating];
            return;
        }
        else
        {
            continue;
        }
    }
}

-(void)didReceiveLocalNotifications
{
    
}

-(void)stopAnimatorOwn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didAnimationStoppedOwn)]) {
        [imgExplotion stopAnimating];
        [imgExplotion removeFromSuperview];
        [self.delegate didAnimationStoppedOwn];
    }
}

-(void)imageTapped:(UITapGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:self];
    NSLog(@"Location = %@",NSStringFromCGPoint(point));
    if (CGRectContainsPoint(imgExplotion.frame, point)) {
        NSLog(@"Contain Point");
        if (self.delegate && [self.delegate respondsToSelector:@selector(didHitTargetOwn)]) {
            [self.delegate didHitTargetOwn];
        }
    }else{
        NSLog(@"Not Contain Point");
        if (self.delegate && [self.delegate respondsToSelector:@selector(didMissTargetOwn)]) {
            [self.delegate didMissTargetOwn];
        }
    }
}

-(void)startAnimationRivalAtPoint:(CGPoint)point
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didAnimationStartedRival)]) {
        [self.delegate didAnimationStartedRival];
    }
    imgExplotionOponents.center=point;
    [self addSubview:imgExplotionOponents];
    [imgExplotionOponents startAnimating];
}
-(void)stopAnimationRival
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didAnimationStoppedRival)]) {
        [self.delegate didAnimationStoppedRival];
    }
    [imgExplotionOponents stopAnimating];
    [imgExplotionOponents removeFromSuperview];
}

 
@end
