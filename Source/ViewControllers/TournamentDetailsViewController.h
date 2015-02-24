//
//  TournamentDetailsViewController.h
//  Chosen
//
//  Created by AppsbeeTechnology on 14/01/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "BaseViewController.h"

@interface TournamentDetailsViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UILabel *navTitleLabel;
@property (nonatomic, strong) IBOutlet UITableView *TournamentDetailsTableView;
-(IBAction)backButtonTapped:(id)sender;
-(IBAction)addButtonTapped:(id)sender;
-(IBAction)slideMenuButtonTapped:(id)sender;
@end
