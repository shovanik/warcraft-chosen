//
//  TournamentDetailsTableViewCell.m
//  Chosen
//
//  Created by AppsbeeTechnology on 14/01/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "TournamentDetailsTableViewCell.h"

@implementation TournamentDetailsTableViewCell

@synthesize turNameLabel, pubButton, priButton, dolarLabel, groupImageView;

- (void)awakeFromNib {
    // Initialization code
    self.pubButton.titleLabel.font = [UIFont fontWithName:@"Garamond" size:13];
    self.priButton.titleLabel.font = [UIFont fontWithName:@"Garamond" size:13];
    self.turNameLabel.font = [UIFont fontWithName:@"Garamond" size:18];
    self.turNameLabel.font = [UIFont fontWithName:@"Garamond" size:18];
    self.dolarLabel.font = [UIFont fontWithName:@"Garamond" size:19];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
