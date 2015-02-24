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
#import "Guilds.h"
#import "STTwitter.h"
NSUserDefaults *pref;
@interface GuildViewController (){
    //UIPageControl *pageControl;
    CGFloat _offset;


}
@property (nonatomic, strong) STTwitterAPI *twitter;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * contentHeightConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * contentTopBarHeightConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * contentMiddleBgHeightConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * contentButtomBarHeightConst;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * damageLeadConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * damageWidthConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * damageHeightConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * damageButtomSpaceConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * damageTextLeadConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * damageTextTopConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * damageBarLeadConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * damageBarButtomConst;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * accurencyLeadConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * accurencyWidthConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * accurencyHeightConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * accurencyButtomSpaceConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * accurencyTextLeadConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * accurencyTextTopConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * accurencyBarLeadConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * accurencyBarButtomConst;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * checkMarkLeadConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * checkMarkTopConst;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * starLeadConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * starTopConst;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * dolartopConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * dolarTrailConst;


@property (nonatomic,strong) IBOutlet NSLayoutConstraint * buyButLeadConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * buyButWeidthConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * buyButHeightConst;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * exchangeButTrailConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * exchangeButWeidthConst;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * exchangeButHeightConst;

@property (nonatomic, strong) IBOutlet UIImageView *background;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableDictionary *guildDictionary;
@property (nonatomic, strong) NSArray *guildImageArray;
@property (nonatomic, strong) NSArray *guildsArray;

@end

@implementation GuildViewController
@synthesize checkMarkLeadConst,checkMarkTopConst,starLeadConst, starTopConst, dolarTrailConst, dolartopConst, buyButLeadConst, buyButWeidthConst, buyButHeightConst, exchangeButTrailConst, exchangeButWeidthConst, exchangeButHeightConst, damageBarButtomConst, accurencyBarButtomConst, accurencyTextTopConst, damageTextTopConst;

@synthesize contentHeightConst, contentTopBarHeightConst, contentMiddleBgHeightConst, contentButtomBarHeightConst, accurencyButtomSpaceConst, accurencyWidthConst, damageWidthConst, damageButtomSpaceConst, damageHeightConst, accurencyHeightConst, damageLeadConst, damageTextLeadConst, damageBarLeadConst, accurencyLeadConst, accurencyTextLeadConst, accurencyBarLeadConst;
@synthesize pageControl, guildDictionary, guildImageArray, guildsArray, damageSlider, accurancySlider;
@synthesize nextButton, previousButton, nabImgView, gNameLabel, cNameLabel;
@synthesize background;
FBLoginView *fbLoginView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _offset = 50;
    pref = [NSUserDefaults standardUserDefaults];
    
    [accurancySlider setMinimumTrackImage: [UIImage imageNamed:@"steps2_progress_bar_iph6.png"] forState: UIControlStateNormal];
    [accurancySlider setMaximumTrackImage: [UIImage imageNamed:@"steps_nav_bg_iphn6.png"] forState: UIControlStateNormal];
   // self.accurancySlider.thumbTintColor = [UIColor redColor];
   // [self.accurancySlider setThumbTintColor:[UIColor redColor]];
    self.guildImageArray = [NSArray arrayWithObjects:@"image1",@"image2", @"image3", @"image4", @"image5",@"image6", nil];

    Guilds *guild1 = [Guilds new];
    guild1.image = @"image1";
    guild1.name = @"MEDIEVAL";
    guild1.star = @"starOne";
    Guilds *guild2 = [Guilds new];
    guild2.image = @"image2";
    guild2.name = @"REBELLION";
    guild2.star = @"starTwo";
    Guilds *guild3 = [Guilds new];
    guild3.image = @"image3";
    guild3.name = @"ABSURDITY";
    guild3.star = @"starThree";
    Guilds *guild4 = [Guilds new];
    guild4.image = @"image4";
    guild4.name = @"TIME KNIGHT";
    guild4.star = @"starTwo";
    Guilds *guild5 = [Guilds new];
    guild5.image = @"image5";
    guild5.name = @"BEL FRONT";
    guild5.star = @"starOne";
    Guilds *guild6 = [Guilds new];
    guild6.image = @"image6";
    guild6.name = @"UNDEAD";
    guild6.star = @"starFour";
    self.guildsArray = [NSArray arrayWithObjects:guild1, guild2, guild3, guild4, guild5, guild6, nil];
    

    [self setUIAndConstraint];
    
       pageControl.pageIndicatorTintColor = [UIColor colorWithRed:60.0f/255.0f green:59.0f/255.0f blue:57.0f/255.0f alpha:1.0f];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:110.0f/255.0f green:207.0f/255.0f blue:246.0f/255.0f alpha:1.0f];
    
    pageControl.numberOfPages = 6;
    
    
    // for ios 7
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self logAllUserDefaults];
}
-(void)setUIAndConstraint
{
    CGRect guildSize;
    
    InfinitePagingView *pagingView = [[InfinitePagingView alloc] init];
    if (IsIphone4) {
        pagingView.frame = CGRectMake(0.f, 50,320, 150.f);
        pagingView.pageSize = CGSizeMake(320.f, self.view.frame.size.height);
        self.gNameLabel.font = [UIFont fontWithName:@"Garamond" size:20];
        guildSize = CGRectMake(0.f, 0.f, 320, 150);

        
    }else if (IsIphone5) {
        pagingView.frame = CGRectMake(0.f, 90,320, 150.f);
        pagingView.pageSize = CGSizeMake(320.f, self.view.frame.size.height);
        self.gNameLabel.font = [UIFont fontWithName:@"Garamond" size:20];
        guildSize = CGRectMake(0.f, 0.f, 320, 150);

        //buyButLeadConst.constant =
        
        
    }else if (IsIphone6) {
        guildSize = CGRectMake(0.f, 0.f, 375, 208);
        pagingView.frame = CGRectMake(0.f, 30, 375, 260.f);
        pagingView.pageSize = CGSizeMake(375.f, self.view.frame.size.height);
        self.gNameLabel.font = [UIFont fontWithName:@"Garamond" size:24];
        
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
        self.gNameLabel.font = [UIFont fontWithName:@"Garamond" size:24];
        
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

    for (Guilds *gObj in guildsArray) {
        UIImage *image = [UIImage imageNamed:gObj.image];
        UIImageView *page = [[UIImageView alloc] initWithImage:image];
        //page.frame = CGRectMake(0.f, 0.f, 320, 150);
        page.frame = guildSize;
        page.contentMode = UIViewContentModeScaleAspectFit;
        [pagingView addPageView:page];
    }
    [previousButton addTarget:pagingView action:@selector(scrollToPreviousPage) forControlEvents:UIControlEventTouchUpInside];
    
    [nextButton addTarget:pagingView action:@selector(scrollToNextPage) forControlEvents:UIControlEventTouchUpInside];
    

    
}
- (void) logAllUserDefaults
{
    NSArray *keys = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys];
    NSArray *values = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allValues];
    for (int i = 0; i < keys.count; i++) {
        NSLog(@"%@: %@", [keys objectAtIndex:i], [values objectAtIndex:i]);
    }
}
#pragma mark - InfinitePagingViewDelegate

- (void)pagingView:(InfinitePagingView *)pagingView didEndDecelerating:(UIScrollView *)scrollView atPageIndex:(NSInteger)pageIndex
{
    Guilds *guild = [guildsArray objectAtIndex:pageIndex];
    pageControl.currentPage = pageIndex;
    gNameLabel.text = guild.name;
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    
    
}




- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    // see https://developers.facebook.com/docs/reference/api/errors/ for general guidance on error handling for Facebook API
    // our policy here is to let the login view handle errors, but to log the results
    NSLog(@"FBLoginView encountered an error=%@", error);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)slideMenuButtonTapped:(id)sender{
//    SlideOutMenuViewController *mVC = nil;
//    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
//        mVC = [[SlideOutMenuViewController alloc] initWithNibName:@"SlideOutMenuViewController_iPhone4" bundle:nil ];
//    }else{
//        mVC = [[SlideOutMenuViewController alloc] initWithNibName:@"SlideOutMenuViewController" bundle:nil ];
//        
//    }
    
    if (self.isSlidemenuOpen) {
        [self closeSlideMenu];
    }else{
        [self openSlideMenu];
    }
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
