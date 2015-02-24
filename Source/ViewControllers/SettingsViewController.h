//
//  SettingsViewController.h
//  Chosen
//
//  Created by appsbee on 19/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "BaseViewController.h"

@interface SettingsViewController : BaseViewController{
    
    
}

@property (nonatomic, strong) IBOutlet UIButton *proSetButton;
@property (nonatomic, strong) IBOutlet UIButton *abtButton;
@property (nonatomic, strong) IBOutlet UIButton *priPoliButton;
@property (nonatomic, strong) IBOutlet UIButton *termsOfUseButton;


-(IBAction)setMenuButtonTapped:(id)sender;
-(IBAction)abtButtonTapped:(id)sender;
-(IBAction)priPolButtonTapped:(id)sender;
-(IBAction)trmUseBtnTapped:(id)sender;

@end
