//
//  DCAViewController.m
//  GCDExercises
//
//  Created by Drew Crawford on 5/23/14.
//  Copyright (c) 2014 DrewCrawfordApps. All rights reserved.
//

#import "DCAViewController.h"
#import "DCASampleLibrary.h"
#import "OneOfTheseThingsIsNotLikeTheOther.h"

@interface DCAViewController () {
    NSArray *blockArray;
}
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation DCAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)exercise1:(id)sender {
    /**Make the label display the status appropriately */
    [UIView animateWithDuration:5.0 animations:^{
        self.label.text = @"animating";
        CGRect frame = self.label.frame;
        frame.origin.y += 50;
        self.label.frame = frame;
    }];
    self.label.text = @"no longer animating";
}

- (IBAction)exercise2:(id)sender {
    /**Expected output:
     object 1
     object 2
     object 3
     object 4
     object 5
     object 6
     */
    NSArray *myArray = @[@1,@2,@3,@4,@5,@6];
    [myArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"object %@",obj);
    }];
}
- (IBAction)exercise3:(id)sender {
    /**Without editing any lines of code (e.g. only adding code, make the output
     
     first
     second
     
     where "second" prints within 100ms of "first" */
    dispatch_async(dispatch_get_main_queue(), ^{
        int time = arc4random() % 10;
        sleep(time);
        NSLog(@"first");
    });
    NSLog(@"second");
}

- (IBAction)exercise4:(id)sender {
/**expected: at the same time the log is printed, the label text changes
 actual: there is a unexplainable delay */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"changing label");
        self.label.text = @"exercise 4";
    });
}


- (IBAction)exercise5:(id)sender {
    
    /*This function prints the integers out of order.  Why?
     
     Can you make the function print the integers in order, only by adding code in the designated area? */
    dispatch_queue_t customQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    /**No edits before this point */
    
    /** Add code only here */
    
    /**No edits beyond this point */
    
    for(int i = 0; i < 100; i++) {
        dispatch_async(customQueue, ^{
            NSLog(@"%d",i);
            sleep(1);
        });
    }
    
}
- (IBAction)exercise6:(id)sender {
    /**Expected: prints a statement after 5 seconds
     Actual: hangs the application */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"Got here");
        });
    });
}
- (IBAction)exercise7:(id)sender {
    /**By only editing in the areas provided, make the output
     
     first
     second
     third
     
     where "second" prints within 100ms of "first" and "third" prints within 100ms of "second" */
    dispatch_async(dispatch_get_main_queue(), ^{
        int time = arc4random() % 10;
        sleep(time);
        NSLog(@"first");
        /** You may add code here */
        NSLog(@"third");
    });
    /** You may add code here */
    NSLog(@"second");
    /** You may add code here */
}

- (IBAction)exercise8:(id)sender {
    /** DCASampleLibrary is a library you maintain.  A user of the library is reporting a bug that the sendAlert function in the library is not really threadsafe.  
     
     They provided this test case.  They expect to see two dialogs, but instead the program hangs.
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [DCASampleLibrary sendAlertWithTitle:@"Hello from background queue"];
    });
    sleep(5);
    [DCASampleLibrary sendAlertWithTitle:@"Hello from normal code"];
    
    /** So some questions are as follows:
     
     1.  Why does this happen?
     2.  Is this a real bug in your library, or is there a problem with the test case?  Or both?
     3.  Fix the problem(s)
     4.  Can you infer any general rules about good practices for library code from this example?*/
    
     
}

- (IBAction)exercise9:(id)sender {
    
    /**This function prints integers 1-100 out of order, but integers 100-200 in order.  Why?
     
     No source code for OneOfTheseThingsIsNotLikeTheOther is provided.  Can you figure out how it works?  Can you write your own version?
     
     */
    dispatch_queue_t queue1 = [OneOfTheseThingsIsNotLikeTheOther queue2];
    
    
    for(int i = 0; i < 100; i++) {
        dispatch_async(queue1, ^{
            NSLog(@"%d",i);
            sleep(1);
        });
    }
    sleep(5);
    dispatch_queue_t queue2 = [OneOfTheseThingsIsNotLikeTheOther queue1];
    for(int i = 100; i < 200; i++) {
        dispatch_async(queue2, ^{
            NSLog(@"%d",i);
            sleep(1);
        });
    }

}








@end
