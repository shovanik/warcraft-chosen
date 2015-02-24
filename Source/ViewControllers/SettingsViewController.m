//
//  SettingsViewController.m
//  Chosen
//
//  Created by appsbee on 19/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "SettingsViewController.h"
#import "SlideOutMenuViewController.h"
#import "Context.h"

@interface SettingsViewController (){
    CGFloat _offset;

}
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * contentViewWidthConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * contentViewHeightConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * profileSetWidthConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * profileSetHeightConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * abtWidthConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * abtHeightConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * abtTopConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * priPolWidthConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * priPolHeightConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * priPolTopConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * trmUseWidthConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * trmUseHeightConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * trmUsetopConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * contentViewCenterConst;

@end

@implementation SettingsViewController
@synthesize proSetButton, abtButton, priPoliButton, termsOfUseButton;
@synthesize contentViewHeightConst, contentViewWidthConst, profileSetHeightConst, profileSetWidthConst, abtHeightConst, abtWidthConst, abtTopConst, priPolHeightConst, priPolWidthConst, priPolTopConst, trmUseHeightConst, trmUseWidthConst, trmUsetopConst,contentViewCenterConst;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _offset = 50;
    if (IsIphone5) {
        contentViewHeightConst.constant = 428;
        contentViewCenterConst.constant=-50;

        abtTopConst.constant = 26;
        priPolTopConst.constant = 26;
        trmUsetopConst.constant = 26;
                
    }else if(IsIphone6){
        contentViewCenterConst.constant=-20;
        contentViewHeightConst.constant = 503;
        contentViewWidthConst.constant = 331;
        profileSetWidthConst.constant = 331;
        profileSetHeightConst.constant = 102;
        abtWidthConst.constant = 331;
        abtHeightConst.constant = 102;
        priPolWidthConst.constant = 331;
        priPolHeightConst.constant = 102;
        trmUseWidthConst.constant = 331;
        trmUseHeightConst.constant = 102;

        abtTopConst.constant = 36;
        priPolTopConst.constant = 36;
        trmUsetopConst.constant = 36;
    }else if (IsIphone6Plus){
        contentViewCenterConst.constant=-75;

        contentViewHeightConst.constant = 655;
        contentViewWidthConst.constant = 366;
        
        profileSetWidthConst.constant = 366;
        profileSetHeightConst.constant = 113;
        abtWidthConst.constant = 113;
        abtHeightConst.constant = 102;
        priPolWidthConst.constant = 366;
        priPolHeightConst.constant = 113;
        trmUseWidthConst.constant = 366;
        trmUseHeightConst.constant = 113;
        abtTopConst.constant = 40;
        priPolTopConst.constant = 40;
        trmUsetopConst.constant = 40;
        
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)setMenuButtonTapped:(id)sender{
    
    self.proSetButton.selected = YES;
    self.abtButton.selected = NO;
    self.priPoliButton.selected = NO;
    self.termsOfUseButton.selected = NO;
//    UIButton *button=(UIButton*)sender;
//    button.selected = YES;
//    if (button.tag == 1) {
//        
//    }else if (button.tag == 2){
//                
//        
//    }
    
}
-(IBAction)abtButtonTapped:(id)sender{
    self.proSetButton.selected = NO;
    self.priPoliButton.selected = NO;
    self.termsOfUseButton.selected = NO;
    self.abtButton.selected = YES;

    
}
-(IBAction)priPolButtonTapped:(id)sender{
    self.proSetButton.selected = NO;
    self.priPoliButton.selected = YES;
    self.termsOfUseButton.selected = NO;
    self.abtButton.selected = NO;
    
}
-(IBAction)trmUseBtnTapped:(id)sender{
    self.proSetButton.selected = NO;
    self.priPoliButton.selected = NO;
    self.termsOfUseButton.selected = YES;
    self.abtButton.selected = NO;
    
}

-(IBAction)slideMenuButtonTapped:(id)sender{
    SlideOutMenuViewController *mVC = nil;
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        mVC = [[SlideOutMenuViewController alloc] initWithNibName:@"SlideOutMenuViewController_iPhone4" bundle:nil ];
    }else{
        mVC = [[SlideOutMenuViewController alloc] initWithNibName:@"SlideOutMenuViewController" bundle:nil ];
        
    }
    //mVC.guildButton.selected = YES;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
