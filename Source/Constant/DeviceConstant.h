//
//  DeviceConstant.h
//  Chosen
//
//  Created by Kaustav Shee on 3/2/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#ifndef Chosen_DeviceConstant_h
#define Chosen_DeviceConstant_h


#endif


#define ___isIpad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define ___isIphone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

#define ___isIphone4_4s ([[UIScreen mainScreen] bounds].size.width==320 && [[UIScreen mainScreen] bounds].size.height==480)
#define ___isIphone5_5s ([[UIScreen mainScreen] bounds].size.width==320 && [[UIScreen mainScreen] bounds].size.height==568)
#define ___isIphone6 ([[UIScreen mainScreen] bounds].size.width==375 && [[UIScreen mainScreen] bounds].size.height==667)
#define ___isIphone6Plus ([[UIScreen mainScreen] bounds].size.width==414 && [[UIScreen mainScreen] bounds].size.height==736)