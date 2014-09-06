//
//  GoogleWearAlertObjc.h
//  Alert
//
//  Created by binaryboy on 9/5/14.
//  Copyright (c) 2014 AhmedHamdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GoogleWearAlertViewObjc.h"
typedef enum GoogleWearAlertTypes {
    Message,
    Warning,
    Error,
    Success
} GoogleWearAlertType;

typedef enum GoogleWearAlertPositions {
    Top,
    Center,
    Bottom
}GoogleWearAlertPosition;
@interface GoogleWearAlertObjc : NSObject

+(GoogleWearAlertObjc*)getInstance;
    
+(void)showAlert:(NSString*)title andWithType:(int)type;

+(void)showAlertMessage:(NSString*)title andImage:(UIImage*)image andWithType:(int)type andWithDuration:(double)duration inViewController:(UIViewController*)viewCotroller;


+(void)showAlertMessage:(NSString*)title andImage:(UIImage*)image andWithType:(int)type andWithDuration:(double)duration inViewController:(UIViewController*)viewCotroller atPostion:(int)GoogleWearAlertPosition canBeDismissedByUser:(BOOL)canDismiss;


-(void)prepareNotificationToBeShown:(GoogleWearAlertViewObjc *)alert;


-(void)presentAlert;
-(void)removeAlert;
-(void)removeCurrentAlert:(GoogleWearAlertViewObjc*)currentView;
- (UIViewController*)useDefaultController;



//@property (nonatomic,strong)NSMutableArray *alertQueue  ;
@property (nonatomic,strong)UIWindow *bgWindow;
@property (nonatomic,strong)UIViewController *defaultViewController;
@property (nonatomic)BOOL alertActive;
@property (nonatomic,strong)NSTimer *timer;

@end
