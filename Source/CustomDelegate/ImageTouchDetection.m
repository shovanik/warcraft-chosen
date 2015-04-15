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
    imgExplotion.animationDuration=0.3;
    imgExplotion.animationRepeatCount=0;
    //imgExplotion.backgroundColor=[UIColor redColor];
    
    
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    [self addGestureRecognizer:tapRecognizer];
    self.userInteractionEnabled = YES;
}

-(void)startAnimator
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didAnimationStarted)]) {
        [self animator];
        [self.delegate didAnimationStarted];
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

-(void)stopAnimator
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didAnimationStopped)]) {
        [imgExplotion stopAnimating];
        [imgExplotion removeFromSuperview];
        [self.delegate didAnimationStopped];
    }
}

-(void)imageTapped:(UITapGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:self];
    NSLog(@"Location = %@",NSStringFromCGPoint(point));
    if (CGRectContainsPoint(imgExplotion.frame, point)) {
        NSLog(@"Contain Point");
        if (self.delegate && [self.delegate respondsToSelector:@selector(didHitTarget)]) {
            [self.delegate didHitTarget];
        }
    }else{
        NSLog(@"Not Contain Point");
        if (self.delegate && [self.delegate respondsToSelector:@selector(didMissTarget)]) {
            [self.delegate didMissTarget];
        }
    }
}


/*
-(void)imageTapped:(UITapGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:self];
    
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    
    int bpr =(int) CGBitmapContextGetBytesPerRow(context);
    unsigned char * data = CGBitmapContextGetData(context);
    if (data != NULL)
    {
        int offset = bpr*round(point.y) + 4*round(point.x);
        int blue = data[offset+0];
        int green = data[offset+1];
        int red = data[offset+2];
        int alpha =  data[offset+3];
        
        CGFloat derivedAlpha=alpha/255.0f;
        
        NSLog(@"%d %d %d %d %f", alpha, red, green, blue,derivedAlpha);
        if (alpha == 0)
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(didClickedBlankPortion)]) {
                [self.delegate didClickedBlankPortion];
            }
        }
        else
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(didClickedOnImageWithLocation:RGB:Alpha:)]) {
                [self.delegate didClickedOnImageWithLocation:point RGB:[UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:derivedAlpha] Alpha:alpha];
            }
        }
    }
    
    UIGraphicsEndImageContext();
}
*/
 
@end
