//
//  AddTournamentTableViewCell.h
//  Chosen
//
//  Created by AppsbeeTechnology on 18/03/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTournamentTableViewCell : UITableViewCell <UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UILabel *labelSelectedValue;
@property (strong, nonatomic) IBOutlet UIImageView *imgBackground;
@property (strong, nonatomic) IBOutlet UIImageView *imgArrow;
@property (strong, nonatomic) IBOutlet UIButton *btnSelect;
@property (strong, nonatomic) IBOutlet UITextField *textFieldTitle;
@property(strong,nonatomic) IBOutlet UIView *vwDropDown;

@end
