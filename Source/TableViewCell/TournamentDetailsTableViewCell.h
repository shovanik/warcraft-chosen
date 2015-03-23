//
//  TournamentDetailsTableViewCell.h
//  Chosen
//
//  Created by AppsbeeTechnology on 14/01/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TournamentDetailsTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *lblTurName;
@property (nonatomic, strong) IBOutlet UIImageView *imgGroup;
@property (nonatomic, strong) IBOutlet UILabel *lblDollar;
@property (nonatomic, strong) IBOutlet UIButton *btnPublic;
@property (nonatomic, strong) IBOutlet UIButton *btnPrivate;

@end
