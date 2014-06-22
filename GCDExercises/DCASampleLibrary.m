//
//  DCASampleLibrary.m
//  GCDExercises
//
//  Created by Drew Crawford on 5/28/14.
//  Copyright (c) 2014 DrewCrawfordApps. All rights reserved.
//

#import "DCASampleLibrary.h"

@implementation DCASampleLibrary
+ (void)sendAlertWithTitle:(NSString *)title {
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIAlertView *uav = [[UIAlertView alloc] initWithTitle:title message:@"My Alert" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [uav show];
    });
}


+ (NSString *)concatenateStrings:(NSString *)string1 and:(NSString *)string2 {
    /* because it is likely that a user will try to do
     "foo"+"bar"+"baz"+"bat"
     let's cache our return value and see if it can be re-used */
    static NSMutableString *oldMutableString;
    if (!oldMutableString || oldMutableString != string1) {
        oldMutableString = [string1 mutableCopy];
    }
    [oldMutableString appendString:string2];
    return oldMutableString;
}
@end
