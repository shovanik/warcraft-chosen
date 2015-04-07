//
//  TopurnamentTableViewCell.h
//  Chosen
//
//  Created by AppsbeeTechnology on 17/03/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuildImageView.h"

@interface TournamentTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView *imgTurnament;
@property (nonatomic, strong) IBOutlet UILabel *lblTurnament;
@property (strong,nonatomic) IBOutlet GuildImageView *imgSlider;
@property(strong,nonatomic) IBOutlet NSLayoutConstraint *consBelowHeight;

@end
