//
//  TournamentViewController.h
//  Chosen
//
//  Created by appsbee on 23/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "BaseViewController.h"

@interface TournamentViewController : BaseViewController
@property (nonatomic, strong) IBOutlet UILabel *mostWinLabel;
@property (nonatomic, strong) IBOutlet UILabel *lastManStandingLabel;
@property (nonatomic, strong) IBOutlet UILabel *kingofTheHillsLabel;
@property (nonatomic, strong) IBOutlet UILabel *navTitleLabel;

-(IBAction)slideMenuButtonTapped:(id)sender;
-(IBAction)tournamentButtonTapped:(id)sender;

@end
