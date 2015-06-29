//
//  SelectRadiusViewController.h
//  Chosen
//
//  Created by AppsbeeTechnology on 14/01/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ModelTournamentCategory.h"

@interface SelectRadiusViewController : BaseViewController

@property(strong,nonatomic) NSString *strTitle;
@property(strong,nonatomic) NSString *strNoOfPlayer;
@property(strong,nonatomic) NSString *strGoldRequired;
@property(strong,nonatomic) NSString *strRanking;
@property(strong,nonatomic) NSString *strPlayTime;
@property(strong,nonatomic) ModelTournamentCategory *tournamentCategory;

@end
