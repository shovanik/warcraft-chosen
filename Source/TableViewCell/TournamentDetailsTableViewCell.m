//
//  TournamentDetailsTableViewCell.m
//  Chosen
//
//  Created by AppsbeeTechnology on 14/01/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "TournamentDetailsTableViewCell.h"

@implementation TournamentDetailsTableViewCell

@synthesize lblTurName, btnPublic, btnPrivate, lblDollar, imgGroup;

- (void)awakeFromNib {
    // Initialization code
    self.btnPublic.titleLabel.font = [UIFont fontWithName:@"Garamond" size:13];
    self.btnPrivate.titleLabel.font = [UIFont fontWithName:@"Garamond" size:13];
    self.lblTurName.font = [UIFont fontWithName:@"Garamond" size:18];
    self.lblTurName.font = [UIFont fontWithName:@"Garamond" size:18];
    self.lblDollar.font = [UIFont fontWithName:@"Garamond" size:19];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
