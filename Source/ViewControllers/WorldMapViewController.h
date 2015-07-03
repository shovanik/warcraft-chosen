//
//  WorldMapViewController.h
//  Chosen
//
//  Created by AppsbeeTechnology on 09/02/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "BaseViewController.h"

@interface WorldMapViewController : BaseViewController

@property(assign,nonatomic) BOOL isCalledFromTournament;

@property(strong,nonatomic) NSString *strTournamentID;


-(void)updateWorldMapWithWebserViceResult:(NSMutableArray*)arrAllUsers;

- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet;

@end
