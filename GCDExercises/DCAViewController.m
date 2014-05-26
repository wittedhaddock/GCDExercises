//
//  DCAViewController.m
//  GCDExercises
//
//  Created by Drew Crawford on 5/23/14.
//  Copyright (c) 2014 DrewCrawfordApps. All rights reserved.
//

#import "DCAViewController.h"

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
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t serialQ2 = dispatch_queue_create("mine", DISPATCH_QUEUE_SERIAL);
    self.label.text = @"animating";
        [UIView animateWithDuration:3.0 animations :^{
            
            CGRect frame = self.label.frame;
            frame.origin.y += 50;
            self.label.frame = frame;
        } completion:^(BOOL finished) {
            self.label.text = @"done animating";
        }];
        
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        
    });
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
    });

  

    NSLog(@"called");


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




@end
