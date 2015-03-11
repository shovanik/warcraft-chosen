//
//  GuildViewController.m
//  Chosen
//
//  Created by appsbee on 18/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "GuildViewController.h"
#import "SlideOutMenuViewController.h"
#import "LandingViewController.h"
#import "Context.h"
#import "AppDelegate.h"
#import "StepOneViewController.h"
#import "ModelGuild.h"
#import "ImageViewGuild.h"


//#import "Guilds.h"
//#import "STTwitter.h"

@interface GuildViewController ()
{
//     STTwitterAPI *twitter;
//    
    IBOutlet NSLayoutConstraint * contentHeightConst;
    IBOutlet NSLayoutConstraint * contentTopBarHeightConst;
    IBOutlet NSLayoutConstraint * contentMiddleBgHeightConst;
    IBOutlet NSLayoutConstraint * contentButtomBarHeightConst;
    
    IBOutlet NSLayoutConstraint * damageLeadConst;
    IBOutlet NSLayoutConstraint * damageWidthConst;
    IBOutlet NSLayoutConstraint * damageHeightConst;
    IBOutlet NSLayoutConstraint * damageButtomSpaceConst;
    IBOutlet NSLayoutConstraint * damageTextLeadConst;
    IBOutlet NSLayoutConstraint * damageTextTopConst;
    IBOutlet NSLayoutConstraint * damageBarLeadConst;
    IBOutlet NSLayoutConstraint * damageBarButtomConst;
    
    IBOutlet NSLayoutConstraint * accurencyLeadConst;
    IBOutlet NSLayoutConstraint * accurencyWidthConst;
    IBOutlet NSLayoutConstraint * accurencyHeightConst;
    IBOutlet NSLayoutConstraint * accurencyButtomSpaceConst;
    IBOutlet NSLayoutConstraint * accurencyTextLeadConst;
    IBOutlet NSLayoutConstraint * accurencyTextTopConst;
    IBOutlet NSLayoutConstraint * accurencyBarLeadConst;
    IBOutlet NSLayoutConstraint * accurencyBarButtomConst;
    
    IBOutlet NSLayoutConstraint * checkMarkLeadConst;
    IBOutlet NSLayoutConstraint * checkMarkTopConst;
    
    IBOutlet NSLayoutConstraint * starLeadConst;
    IBOutlet NSLayoutConstraint * starTopConst;
    
    IBOutlet NSLayoutConstraint * dolartopConst;
    IBOutlet NSLayoutConstraint * dolarTrailConst;
    
    
    IBOutlet NSLayoutConstraint * buyButLeadConst;
    IBOutlet NSLayoutConstraint * buyButWeidthConst;
    IBOutlet NSLayoutConstraint * buyButHeightConst;
    
    IBOutlet NSLayoutConstraint * exchangeButTrailConst;
    IBOutlet NSLayoutConstraint * exchangeButWeidthConst;
    IBOutlet NSLayoutConstraint * exchangeButHeightConst;
    
    IBOutlet UIImageView *background;
    IBOutlet UIImageView *imgStar;
    IBOutlet UIPageControl *pageControl;
    
    
    IBOutlet UIButton *btnNext;
    IBOutlet UIButton *btnPrevious;
    IBOutlet UIImageView *nabImgView;
    IBOutlet UILabel *lblGuildName;
    IBOutlet UILabel *lblPrice;
    IBOutlet UILabel *lblDamage;
    IBOutlet UILabel *lblAccuracy;
    IBOutlet UISlider *damageSlider, *accurancySlider;

    
    
    
    
    NSMutableDictionary *guildDictionary;
    NSMutableArray *arrAllGuilds,*arrUserGuilds;
    
    InfinitePagingView *pagingView;
    
    CGRect guildSize;
}


@end

@implementation GuildViewController

#pragma mark
#pragma mark View Initialization Method
#pragma mark


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUIAndConstraint];
    
       pageControl.pageIndicatorTintColor = [UIColor colorWithRed:60.0f/255.0f green:59.0f/255.0f blue:57.0f/255.0f alpha:1.0f];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:110.0f/255.0f green:207.0f/255.0f blue:246.0f/255.0f alpha:1.0f];
    
    pageControl.numberOfPages = 6;
    
    
    // for ios 7
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadAllGuildFromServer];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark
#pragma mark Load Data From Server Method
#pragma mark

-(void)loadAllGuildFromServer
{
    [[WebService service] callGetAllGuildWithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
        if (isError) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:strMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }else{
            if ([result isKindOfClass:[NSMutableArray class]]) {
                arrAllGuilds=(NSMutableArray*)result;
                [self loadAllGuildForUser];
            }
        }
    }];
}
-(void)loadAllGuildForUser
{
    [[WebService service] callGetGuildsForUserId:user.strID WithCompletionHandler:^(id result, BOOL isError, NSString *strMessage) {
        if (isError) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:strMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }else{
            if ([result isKindOfClass:[NSMutableArray class]]) {
                arrUserGuilds=(NSMutableArray*)result;
                [self makeUIDesign];
                [self updateUIForGuild:[arrAllGuilds firstObject]];
            }
        }
    }];
}

#pragma mark
#pragma mark Design Method
#pragma mark

-(void)setUIAndConstraint
{
    
    
    pagingView = [[InfinitePagingView alloc] init];
    if (IsIphone4) {
        pagingView.frame = CGRectMake(0.f, 50,320, 150.f);
        pagingView.pageSize = CGSizeMake(320.f, self.view.frame.size.height);
        lblGuildName.font = [UIFont fontWithName:@"Garamond" size:20];
        guildSize = CGRectMake(0.f, 0.f, 320, 150);

        
    }else if (IsIphone5) {
        pagingView.frame = CGRectMake(0.f, 90,320, 150.f);
        pagingView.pageSize = CGSizeMake(320.f, self.view.frame.size.height);
        lblGuildName.font = [UIFont fontWithName:@"Garamond" size:20];
        guildSize = CGRectMake(0.f, 0.f, 320, 150);

        //buyButLeadConst.constant =
        
        
    }else if (IsIphone6) {
        guildSize = CGRectMake(0.f, 0.f, 375, 208);
        pagingView.frame = CGRectMake(0.f, 30, 375, 260.f);
        pagingView.pageSize = CGSizeMake(375.f, self.view.frame.size.height);
        lblGuildName.font = [UIFont fontWithName:@"Garamond" size:24];
        
        checkMarkLeadConst.constant = 20;
        checkMarkTopConst.constant = 8;
        starLeadConst.constant = 13;
        starTopConst.constant = 25;
        dolartopConst.constant = 11;
        dolarTrailConst.constant = 20;
        
        damageTextTopConst.constant = -8;
        damageLeadConst.constant = -41;
        damageTextLeadConst.constant = 6;
        damageBarLeadConst.constant = 9;
        damageBarButtomConst.constant = -13;
        
        accurencyTextTopConst.constant = -8;
        accurencyLeadConst.constant = -41;
        accurencyTextLeadConst.constant = 6;
        accurencyBarLeadConst.constant = 9;
        accurencyBarButtomConst.constant = 13;
        
        buyButLeadConst.constant = 48;
        buyButWeidthConst.constant = 131;
        buyButHeightConst.constant = 41;
        
        exchangeButTrailConst.constant = 48;
        exchangeButWeidthConst.constant = 131;
        exchangeButHeightConst.constant = 41;
        
        contentHeightConst.constant = 406;
        contentTopBarHeightConst.constant = 86;
        contentButtomBarHeightConst.constant = 75;
        accurencyButtomSpaceConst.constant = 15;
        accurencyWidthConst.constant = 332;
        damageButtomSpaceConst.constant = 9;
        damageWidthConst.constant = 332;
        damageHeightConst.constant = 73;
        accurencyHeightConst.constant = 73;
        checkMarkTopConst.constant = 8;
        starTopConst.constant = 25;
        dolartopConst.constant = 10;
        
    }else{
        guildSize = CGRectMake(0.f, 0.f, 414, 230);

        pagingView.frame = CGRectMake(0.f, 30, 414, 260.f);
        pagingView.pageSize = CGSizeMake(414.f, self.view.frame.size.height);
        lblGuildName.font = [UIFont fontWithName:@"Garamond" size:24];
        
        checkMarkLeadConst.constant = 22;
        checkMarkTopConst.constant = 9;
        starLeadConst.constant = 14;
        starTopConst.constant = 28;
        dolartopConst.constant = 12;
        dolarTrailConst.constant = 22;
        
        damageTextTopConst.constant = -9;
        damageLeadConst.constant = -45;
        damageTextLeadConst.constant = 7;
        damageBarLeadConst.constant = 10;
        damageBarButtomConst.constant = -14;
        
        accurencyTextTopConst.constant = -9;
        accurencyLeadConst.constant = -45;
        accurencyTextLeadConst.constant = 7;
        accurencyBarLeadConst.constant = 10;
        accurencyBarButtomConst.constant = 14;

        buyButLeadConst.constant = 52;
        buyButWeidthConst.constant = 144;
        buyButHeightConst.constant = 45;
        
        exchangeButTrailConst.constant = 52;
        exchangeButWeidthConst.constant = 144;
        exchangeButHeightConst.constant = 45;
        
        contentHeightConst.constant = 484;
        contentTopBarHeightConst.constant = 95;
        contentButtomBarHeightConst.constant = 83;
        accurencyButtomSpaceConst.constant = 17;
        accurencyWidthConst.constant = 367;
        damageButtomSpaceConst.constant = 10;
        damageWidthConst.constant = 367;
        damageHeightConst.constant = 81;
        accurencyHeightConst.constant = 81;
    }
    pagingView.delegate = self;
    pagingView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:pagingView];

    
}

-(void)makeUIDesign
{
    for (ModelGuild *gObj in arrAllGuilds) {
        ImageViewGuild *imageView=[[ImageViewGuild alloc] initWithFrame:guildSize];
        [pagingView addPageView:imageView];
        [imageView setImageFromURL:gObj.strGuildImage];
    }
    [btnPrevious addTarget:pagingView action:@selector(scrollToPreviousPage) forControlEvents:UIControlEventTouchUpInside];
    
    [btnNext addTarget:pagingView action:@selector(scrollToNextPage) forControlEvents:UIControlEventTouchUpInside];
}

-(void)updateUIForGuild:(ModelGuild*)guild
{
    lblGuildName.text = [guild.strName uppercaseString];
    lblDamage.text=[NSString stringWithFormat:@"Damage %@%%",[guild.strDamage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    lblPrice.text=[NSString stringWithFormat:@"%@ $",[guild.strPrice stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    lblAccuracy.text=[NSString stringWithFormat:@"Accuracy %@%%",[guild.strAccuracy stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    switch ([[guild.strRating stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] integerValue]) {
        case 0:
            imgStar.image=[UIImage imageNamed:@"zero_star.png"];
            break;
        case 1:
            imgStar.image=[UIImage imageNamed:@"one_star.png"];
            break;
        case 2:
            imgStar.image=[UIImage imageNamed:@"two_star.png"];
            break;
        case 3:
            imgStar.image=[UIImage imageNamed:@"three_star.png"];
            break;
        case 4:
            imgStar.image=[UIImage imageNamed:@"four_star.png"];
            break;
        case 5:
            imgStar.image=[UIImage imageNamed:@"five_star.png"];
            break;
        default:
            break;
    }
}

#pragma mark
#pragma mark InfinitePagingViewDelegate Method
#pragma mark

- (void)pagingView:(InfinitePagingView *)pagingView didEndDecelerating:(UIScrollView *)scrollView atPageIndex:(NSInteger)pageIndex
{
    ModelGuild *guild = [arrAllGuilds objectAtIndex:pageIndex];
    pageControl.currentPage = pageIndex;
    [self updateUIForGuild:guild];
}

@end
