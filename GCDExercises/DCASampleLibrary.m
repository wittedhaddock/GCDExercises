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
    dispatch_sync(dispatch_get_main_queue(), ^{
        UIAlertView *uav = [[UIAlertView alloc] initWithTitle:title message:@"My Alert" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [uav show];
    });
}
@end
