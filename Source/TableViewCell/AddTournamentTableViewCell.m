//
//  AddTournamentTableViewCell.m
//  Chosen
//
//  Created by AppsbeeTechnology on 18/03/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "AddTournamentTableViewCell.h"

@implementation AddTournamentTableViewCell
@synthesize imgBackground, labelTitle, imgArrow, textFieldTitle;
- (void)awakeFromNib {
    // Initialization code
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
