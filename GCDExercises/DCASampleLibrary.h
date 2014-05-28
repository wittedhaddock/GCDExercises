//
//  DCASampleLibrary.h
//  GCDExercises
//
//  Created by Drew Crawford on 5/28/14.
//  Copyright (c) 2014 DrewCrawfordApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCASampleLibrary : NSObject
/** Displays an alert.
 This function is threadsafe and can be called from any thread. */
+(void) sendAlertWithTitle:(NSString*) title;
@end
