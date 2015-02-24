//
//  GuildViewController.h
//  Chosen
//
//  Created by appsbee on 18/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "BaseViewController.h"
#import "InfinitePagingView.h"



@interface GuildViewController : BaseViewController<UIScrollViewDelegate, UIPageViewControllerDelegate, InfinitePagingViewDelegate>{
    
    
}
@property (nonatomic, strong) IBOutlet UIButton *nextButton;
@property (nonatomic, strong) IBOutlet UIButton *previousButton;
@property (nonatomic, strong) IBOutlet UIImageView *nabImgView;
@property (nonatomic, strong) IBOutlet UILabel *gNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *cNameLabel;
@property (nonatomic, strong) IBOutlet UISlider *damageSlider, *accurancySlider;



@end
