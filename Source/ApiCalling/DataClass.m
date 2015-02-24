//
//  DataClass.m
//  Kicka
//
//  Created by Cygnus Infomedia on 4/8/14.
//  Copyright (c) 2014 cygnusimfomedia. All rights reserved.
//

#import "DataClass.h"

@implementation DataClass


- (id) init {
    
    if (self = [super init]) {
        
        //  http://192.168.0.1/Chosen/api/user/all_login_user_radius
        
       // ROOT_LOCATION = @"http://192.168.0.1/Chosen/";
        
       ROOT_LOCATION = @"http://chosen.sulavmart.com/";
    
        //LOGIN_API_LOCATION = [ROOT_LOCATION stringByAppendingString: @"api/user/login/"];
        LOGIN_API_LOCATION = [ROOT_LOCATION stringByAppendingString: @"api/user/login_radius/"];
        REG_API_LOCATION =   [ROOT_LOCATION stringByAppendingString: @"registration/register"];
        RADIOUS_API_LOCATION =   [ROOT_LOCATION stringByAppendingString: @"api/user/all_login_user_radius"];
 
        SITE_LOCATION = ROOT_LOCATION;
    }
    return self;
}


-(NSString*) RootLocation{
    return ROOT_LOCATION;
}

-(NSString*) RegApiLocation{
    return REG_API_LOCATION;
}
-(NSString*) LoginApiLocation{
    return LOGIN_API_LOCATION;
}
- (NSString*) RadiousApiLocation{
    return RADIOUS_API_LOCATION;
}

-(NSString*) SiteLocation{
    return SITE_LOCATION;
}

//Used for Gobal Vriable Such as UserID

@synthesize USER_NO, reponseValue,/*isLoginButtonClicked*/isApiCalled;

static DataClass *instance = nil;

+(DataClass *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [DataClass new];
        }
    }
    return instance;
}

//Used for Gobal Vriable Such as UserID


- (NSString *)percentEscapeString:(NSString *)string
{
    NSString *result = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                 (CFStringRef)string,
                                                                                 (CFStringRef)@" ",
                                                                                 (CFStringRef)@"",
                                                                                 kCFStringEncodingUTF8));
    return [result stringByReplacingOccurrencesOfString:@" " withString:@"+"];
}
//Escape Characters-> :/?@!$&'()*+,;=

/************************** API CALL METHOD **************************/
- (void)apiCall: (NSDictionary *)params method:(NSString*) method completionHandler:(void (^)(id , NSError *))completionBlock
{
    NSMutableURLRequest *request;
   // NSURLRequest *request;
    
    
    if ([method isEqualToString:@"POST"]) {
        //NSLog(@" post data");
        NSString *requestUrl;
        
        if(isApiCalled == 1)
            requestUrl = LOGIN_API_LOCATION;
        else if(isApiCalled == 2)
            requestUrl = REG_API_LOCATION;
        else
            requestUrl = RADIOUS_API_LOCATION;
        
        NSLog(@"URL: %@",requestUrl);
        
        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        
        /* Using Querystring only */
        
        NSMutableString *postParams = [NSMutableString stringWithString:@""];
        NSMutableArray *arr=[[NSMutableArray alloc] init];
        
        if ([params isKindOfClass:[NSDictionary class]]) {
            for (NSString *key in params) {
                [arr addObject:[NSString stringWithFormat:@"%@=%@", key, [params objectForKey:key]]];
                //NSLog(@"Request :%@",postParams);
            }
        }
        
        postParams=[NSMutableString stringWithString:[arr componentsJoinedByString:@"&"]];
        
        NSData *RequestPostData = [NSData dataWithBytes: [postParams UTF8String] length: [postParams length]];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[RequestPostData length]];
         //NSLog(@"Post Length :%@",postLength);
         //NSLog(@"RequestData :%@",RequestPostData);
         
         [request setHTTPMethod:@"POST"];
         [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
         [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
         [request setHTTPBody:RequestPostData];
        
    }
    else{
        //NSLog(@" get data");
        
        NSString *requestUrl;
        
        if(isApiCalled == 1)
        requestUrl = LOGIN_API_LOCATION;
        else if(isApiCalled == 2)
            requestUrl = REG_API_LOCATION;
        else
            requestUrl = RADIOUS_API_LOCATION;
        
        NSString *format = [requestUrl stringByAppendingString:@"?"];
        NSMutableString *url = [NSMutableString stringWithString:format];
        
        
        if ([params isKindOfClass:[NSDictionary class]]) {
            for (NSString *key in params) {
                [url appendString:[NSString stringWithFormat:@"&%@=%@", key, [params objectForKey:key]]];
                
            }
        }
        

        
        //NSString *requestUrl = [NSString stringWithFormat:@"%@", API_LOCATION];
        
        //[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *urll=[self percentEscapeString:url];
        
        //NSLog(@"Request :%@",urll);
        
        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urll] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        //NSLog(@"%@",request);
        
        //NSError *error;
        //NSLog(@"%@", [error localizedDescription]);


    }
    
    
    // Make an NSOperationQueue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue setName:@"api"];
    
    // Send an asyncronous request on the queue
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        // If there was an error getting the data
        if (error) {
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completionBlock(nil, error);
            });
            return;
        }
        
        
        // Decode the data
        NSError *jsonError;
        id responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        // If there was an error decoding the JSON
        if (jsonError) {
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                
            });
            return;
        }
        
        // All looks fine, lets call the completion block with the response data
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            completionBlock(responseDict, nil);
        });
    }];
}
/************************** API CALL METHOD **************************/

@end
