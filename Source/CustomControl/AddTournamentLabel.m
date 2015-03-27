//
//  AddTournamentLabel.m
//  Chosen
//
//  Created by Kaustav Shee on 3/24/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "AddTournamentLabel.h"

@implementation AddTournamentLabel

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

-(void)initialize
{
    self.layer.borderWidth=1.0f;
    self.layer.borderColor=[[UIColor colorWithRed:50.0f/255.0f green:65.0f/255.0f blue:65.0f/255.0f alpha:1.0f] CGColor];
}

@end
