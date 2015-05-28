//
//  ModelInAppPurchase.m
//  Chosen
//
//  Created by jayantada on 25/05/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "ModelInAppPurchase.h"

@implementation ModelInAppPurchase

+ (ModelInAppPurchase *)sharedInstance {
    static dispatch_once_t once;
    static ModelInAppPurchase * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"com.com.chosenn.battelaxe",
                                      @"com.com.chosenn.battelcatapult",
                                      @"com.com.chosenn.crossbowww",
                                      @"com.com.chosenn.helmett",
                                      @"com.com.chosenn.longboww",
                                      @"com.com.chosenn.macee",
                                      @"com.com.chosenn.metalshieldd",
                                      @"com.com.chosenn.pikee",
                                      @"com.com.chosenn.rustydaggerr",
                                      @"com.com.chosenn.sabree",
                                      @"com.com.chosenn.slingg",
                                      @"com.com.chosenn.throwingknievess",
                                      @"com.com.chosenn.throwingspearr",
                                      @"com.com.chosenn.warhammerr",
                                      @"com.com.chosenn.woodenshieldd",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
