//
//  Context.h
//
//  Created by Ranjan Sahu on 16/12/114.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>




@interface Context : NSObject
{
	NSMutableDictionary * m_settings;
}

@property (nonatomic, retain) NSMutableDictionary * m_settings;

/** 
  * Returns Singleton instance of this context class
  * @return singleton instance
  */
+ (Context *) getInstance;
/** 
  * Returns Directory path for Appplications Documents
  * @return path
  */
/** 
  * Returns Value for key
  * 
  * @param keyId Key string
  * 
  * @return value for the key 
  			return default value if entry not found
  			return nil if entry not found and no default value
  */
/** 
  * Sets Value for key
  * If val is 'nil', this will remove the entry for keyId from storage
  *
  * @param val Value to be set
  * @param keyId Key string
  * 
  * @return void
  */


-(BOOL)isPad;
-(BOOL)checkIsDeviceVersionHigherThanRequiredVersion:(NSString *)requiredVersion;
-(BOOL)screenPhysicalSizeForIPhoneClassic;

-(BOOL) isDeviceInPortraitMode;

@end


