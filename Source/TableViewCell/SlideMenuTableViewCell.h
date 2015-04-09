//
//  SlideMenuTableViewCell.h
//  Chosen
//
//  Created by Kaustav Shee on 2/20/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideMenuTableViewCell : UITableViewCell

@property(strong,nonatomic) IBOutlet UIImageView *imgBackGround;
@property(strong,nonatomic) IBOutlet UIImageView *imgIcon;
@property(strong,nonatomic) IBOutlet UILabel *lblText;
@property(strong,nonatomic) IBOutlet NSLayoutConstraint *consImageHeight;

@end
