//
//  AvatarSelectionViewController.h
//  Chosen
//
//  Created by Kaustav Shee on 3/4/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AvatarSelectionControllerDelegate <NSObject>

@optional
-(void)selectedAvatar:(UIImage*)image;

@end

@interface AvatarSelectionViewController : UIViewController

@property(weak,nonatomic) id <AvatarSelectionControllerDelegate> delegate;

@end
