//
//  GoogleWearAlertViewObjc.h
//  Alert
//
//  Created by binaryboy on 9/5/14.
//  Copyright (c) 2014 AhmedHamdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoogleWearAlertViewObjc : UIView<UIGestureRecognizerDelegate>
{
   
}

/** The displayed title of this message */
@property (nonatomic,strong)NSString *title;
/** The view controller this message is displayed in, only used to size the alert*/
@property (nonatomic,strong) UIViewController *viewController;

/** The duration of the displayed message. If it is 0.0, it will automatically be calculated */
@property (nonatomic) double duration;

/** The position of the message (top or bottom) */
@property (nonatomic) int alertPosition;

/** Is the message currenlty fully displayed? Is set as soon as the message is really fully visible */
@property (nonatomic) BOOL messageIsFullyDisplayed;

/** If you'd like to customise the image shown with the alert */
@property (nonatomic,strong) UIImage *iconImage;

/** Internal properties needed to resize the view on device rotation properly */
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *iconImageView;



- (id)initWithTitle:(NSString*)title andImage:(UIImage*)image andWithType:(int)type andWithDuration:(double)duration inViewController:(UIViewController*)viewCotroller atPostion:(int)GoogleWearAlertPosition canBeDismissedByUser:(BOOL)canDismiss;
@end
