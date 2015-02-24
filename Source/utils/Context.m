//
//  Context.m
//
//
#import <QuartzCore/QuartzCore.h>
#import "Context.h"


//#import "CommonDefs.h"
//#import "SafetyNetContact.h"

// This is a singleton class, see below


@interface Context ()
/** 
  * Check if APP_CONFIG_FILENAME exists in docs folder
  */

@end

@implementation Context
@synthesize m_settings;


- (id) init
{
	self = [super init];
	return self;
}



+ (Context *) getInstance
{
    static Context *context_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        context_instance=[[Context alloc] init];
    });
    return context_instance;
}



+ (NSString *) GetResourceDirectoryPath
{
	return [[NSBundle mainBundle] resourcePath];
}

-(BOOL)isPad
{
    /*
    BOOL checkPad;
    NSRange range = [[[UIDevice currentDevice] model] rangeOfString:@"iPad"];
    if(range.location==NSNotFound)
    {
        checkPad=NO;
    }
    else {
        checkPad=YES;
    }
    return checkPad;
     */
    //Ranjan : return NO always, to show iPhone4 XIB on ipad, till ipad XIBs are ready.
    return NO;
}
- (BOOL)checkIsDeviceVersionHigherThanRequiredVersion:(NSString *)requiredVersion
{
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    if ([currSysVer compare:requiredVersion options:NSNumericSearch] != NSOrderedAscending)
    {
        return YES;
    }
    return NO;
}

-(BOOL)screenPhysicalSizeForIPhoneClassic
{
    BOOL screenSize = YES;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if (result.height <= 568)
            screenSize = YES;  // iPhone 4S / 4th Gen iPod Touch or earlier
        else
            screenSize = NO;  // iPhone 5
    } else {
        screenSize = YES; // For iPad, show iPhone4 XIB for now
    }
    
   // NSLog(@"Screen size %f",[[UIScreen mainScreen] bounds].size.height);
    
    return screenSize;
}
/*if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ){
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if( screenHeight < screenWidth ){
        screenHeight = screenWidth;
    }
    
    if( screenHeight > 480 && screenHeight < 667 ){
        NSLog(@"iPhone 5/5s");
    } else if ( screenHeight > 480 && screenHeight < 736 ){
        NSLog(@"iPhone 6");
    } else if ( screenHeight > 480 ){
        NSLog(@"iPhone 6 Plus");
    } else {
        NSLog(@"iPhone 4/4s");
    }
}*/

-(BOOL) isDeviceInPortraitMode{
    BOOL portraitOrientation = YES;
    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    if (deviceOrientation != UIDeviceOrientationLandscapeLeft &&
        deviceOrientation != UIDeviceOrientationLandscapeRight)
    {
        portraitOrientation = YES;
    }else{
        portraitOrientation =  NO;
    }
    
    return portraitOrientation;
}









@end
