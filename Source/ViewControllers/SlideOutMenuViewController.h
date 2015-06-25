//
//  SlideOutMenuViewController.h
//  Chosen
//
//  Created by appsbee on 18/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "BaseViewController.h"
#import "GuildViewController.h"
#import "Context.h"

@protocol SlideOutMenuDelegate <NSObject>

@optional

-(void)didWorlMapClicked;
-(void)didGuildClicked;
-(void)didContractClicked;
-(void)didTournamentClicked;
-(void)didSettingsClicked;
-(void)didLogoutTapped;

@end

@interface SlideOutMenuViewController : UIViewController

@property(weak,nonatomic) id <SlideOutMenuDelegate> delegate;

-(void)setAvtarImageForURL:(NSURL*)urlImg;


@end
