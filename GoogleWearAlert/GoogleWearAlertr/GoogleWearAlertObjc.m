//
//  GoogleWearAlertObjc.m
//  Alert
//
//  Created by binaryboy on 9/5/14.
//  Copyright (c) 2014 AhmedHamdy. All rights reserved.
//

#import "GoogleWearAlertObjc.h"

@implementation GoogleWearAlertObjc
static GoogleWearAlertObjc *singletone = nil;
// Constants
const NSTimeInterval presentAnimationDuration = 1.2;
const NSTimeInterval dismissAnimationDuration  = 0.3;
const  CGFloat springDamping= 0.6;
const  CGFloat springVelocity= 10;
NSMutableArray *alertQueue  ;



+ (GoogleWearAlertObjc*)getInstance {
    if(singletone == nil) {
        singletone = [GoogleWearAlertObjc alloc];
        alertQueue =[[NSMutableArray alloc]init];

    }

    return singletone;
}
+(void)showAlert:(NSString *)title andWithType:(int)type{

    [GoogleWearAlertObjc showAlertMessage:title andImage:nil andWithType:type andWithDuration:2.5 inViewController:[[GoogleWearAlertObjc getInstance] useDefaultController]];

}
+(void)showAlertMessage:(NSString*)title andImage:(UIImage*)image andWithType:(int)type andWithDuration:(double)duration inViewController:(UIViewController*)viewCotroller{
    
    [GoogleWearAlertObjc showAlertMessage:title andImage:image andWithType:type andWithDuration:duration inViewController:viewCotroller atPostion:Center canBeDismissedByUser:YES];
}


+(void)showAlertMessage:(NSString*)title  andImage:(UIImage*)image andWithType:(int)type andWithDuration:(double)duration inViewController:(UIViewController*)viewCotroller atPostion:(int)GoogleWearAlertPosition canBeDismissedByUser:(BOOL)canDismiss{

    GoogleWearAlertViewObjc  *alertView=[[GoogleWearAlertViewObjc alloc]initWithTitle:title andImage:image andWithType:type andWithDuration:duration inViewController:viewCotroller atPostion:GoogleWearAlertPosition canBeDismissedByUser:canDismiss];
    
    [[GoogleWearAlertObjc getInstance]prepareNotificationToBeShown:alertView];
}


-(void)prepareNotificationToBeShown:(GoogleWearAlertViewObjc*)alert{
    UILabel *title = alert.titleLabel;
    for (GoogleWearAlertViewObjc *message in alertQueue ){
        if (message.titleLabel == title ){
            return;
        }
    }
    [alertQueue addObject:alert];
    
    if (!self.alertActive) {
        [self presentAlert];
    }

}


-(void)presentAlert{
    if (alertQueue.count == 0)
    {
        return ;
    
    }
    self.alertActive = YES;
    
    CGAffineTransform scale = CGAffineTransformMakeScale(0.1, 0.1);
    CGAffineTransform rotate = CGAffineTransformRotate(scale, M_PI);
    CGAffineTransform transform = CGAffineTransformConcat(scale, rotate);
    
    GoogleWearAlertViewObjc *currentView =   (GoogleWearAlertViewObjc*)[alertQueue firstObject];
    currentView.transform = transform;
    
    self.bgWindow.windowLevel = UIWindowLevelAlert;
    self.bgWindow.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
    CGRect windowFrame = UIScreen.mainScreen.applicationFrame;
    NSLog(@"%f WWWW",windowFrame.size.width);
    self.bgWindow.frame = CGRectMake(windowFrame.origin.x, windowFrame.origin.y - 20, windowFrame.size.width, windowFrame.size.height + 20);
    self.bgWindow.hidden = NO;
    [self.bgWindow addSubview:currentView];
    UIWindow* mainWindow = [[UIApplication sharedApplication] keyWindow];
    [mainWindow addSubview: currentView];

    [UIView animateWithDuration:presentAnimationDuration delay:0.0 usingSpringWithDamping:springDamping initialSpringVelocity:springVelocity options:UIViewAnimationOptionCurveEaseIn animations:^{ self.bgWindow.alpha = 1.0;
        self.bgWindow.hidden = false;
        currentView.transform = CGAffineTransformIdentity;
    }  completion:^(BOOL finished){currentView.messageIsFullyDisplayed = YES;}];
    
    
     
    double timeInterval =  currentView.duration;
    self.timer= [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(removeAlert) userInfo:@{@"currentView" : currentView} repeats:NO];
}
-(void)removeAlert{
    GoogleWearAlertViewObjc *currentView =(GoogleWearAlertViewObjc*)[self.timer.userInfo objectForKey:@"currentView"];
                                           
    [self removeCurrentAlert:currentView];
}
-(void)removeCurrentAlert:(GoogleWearAlertViewObjc*)currentView {

    [self.timer invalidate];
    currentView.messageIsFullyDisplayed = NO;

    [UIView animateWithDuration:dismissAnimationDuration delay:0.0 usingSpringWithDamping:springDamping initialSpringVelocity:springVelocity options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction animations:^{
        currentView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    
    } completion:^(BOOL finished){
       
        /*==============================*/
        
        [UIView animateWithDuration:dismissAnimationDuration delay:0.0 usingSpringWithDamping:springDamping initialSpringVelocity:springVelocity options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction animations:^{
            
            self.bgWindow.alpha = 0.0;
            currentView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            currentView.alpha = 0.0;
        }
         completion:^(BOOL finished){
             /*=================222=============*/

             [currentView removeFromSuperview];
             
             self.bgWindow.hidden = YES;
              // self.alertQueue.removeObject(currentView)
             [alertQueue removeObject:currentView];
             self.alertActive = NO;
        
               if (alertQueue.count > 0 )
               {
                   [self presentAlert];
               
               }
             
             /*=================222=============*/

           }];

     
     }];

}



- (UIViewController*)useDefaultController{

    UIViewController * defaultVC;
    if ((defaultVC = self.defaultViewController)) {
        return defaultVC;
    }else{
        self.defaultViewController = UIApplication.sharedApplication.keyWindow.rootViewController;
        return self.defaultViewController;
    }
    
}
@end
