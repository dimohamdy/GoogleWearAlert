//
//  ViewController.m
//  Alert
//
//  Created by binaryboy on 9/5/14.
//  Copyright (c) 2014 AhmedHamdy. All rights reserved.
//

#import "ViewController.h"
#import "GoogleWearAlertObjc.h"
@interface ViewController ()
            


@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated{

    [[GoogleWearAlertObjc getInstance]prepareNotificationToBeShown:[[GoogleWearAlertViewObjc alloc]initWithTitle:@"Message" andImage:nil andWithType:Message andWithDuration:2.5 inViewController:self atPostion:Bottom canBeDismissedByUser:NO]];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
