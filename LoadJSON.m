//
//  LoadJSON.m
//  Demo
//
//  Created by MARK GALLEN on 5/22/14.
//  Copyright (c) 2014 Double Encore. All rights reserved.
//

#import "LoadJSON.h"

@implementation LoadJSON
+(NSDictionary *)loadJSONData:(NSString *)urlStr
{
    NSError *error;
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSData *data = [ NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error ];
    if (!data)
    {
        NSLog(@"Download Failure!");
    }
    
    id dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (dictionary == nil)
    {
        NSLog(@"Could not load JSON");
        return nil;
    }
    
    return dictionary;
}
@end
