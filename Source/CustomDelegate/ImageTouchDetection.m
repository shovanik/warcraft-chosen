//
//  ImageTouchDetection.m
//  ColorPickerFromImage
//
//  Created by Kaustav Shee on 3/31/15.
//  Copyright (c) 2015 AppsBee. All rights reserved.
//

#import "ImageTouchDetection.h"

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
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    [self addGestureRecognizer:tapRecognizer];
    self.userInteractionEnabled = YES;
}

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



@end
