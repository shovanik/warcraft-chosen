//
//  TournamentDetailsViewController.h
//  Chosen
//
//  Created by AppsbeeTechnology on 14/01/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "BaseViewController.h"

@class ModelTournamentCategory;

@interface TournamentDetailsViewController : BaseViewController

@property(weak,nonatomic) ModelTournamentCategory *tournamentCategory;

@end
