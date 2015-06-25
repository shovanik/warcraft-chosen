//
//  WorldMapViewController.h
//  Chosen
//
//  Created by AppsbeeTechnology on 09/02/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "BaseViewController.h"

@interface WorldMapViewController : BaseViewController

- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet;

@end
