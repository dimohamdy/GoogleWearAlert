//
//  GoogleWearAlertViewObjc.m
//  Alert
//
//  Created by binaryboy on 9/5/14.
//  Copyright (c) 2014 AhmedHamdy. All rights reserved.
//

#import "GoogleWearAlertViewObjc.h"
#import "UIColor+Alert.h"
#import "GoogleWearAlertObjc.h"

//Constants
const CGFloat alertViewSize = 0.4; // 40% of presenting viewcontrollers width
const CGFloat imageViewSize = 0.4; //4 0% of AlertViews width
const CGFloat imageViewOffsetFromCentre = 0.25; // Offset of image along Y axis
const CGFloat titleLabelWidth = 0.7 ;// 70% of AlertViews width
const CGFloat titleLabelHeight = 30;
const CGFloat navControllerHeight = 44;
@implementation GoogleWearAlertViewObjc{
    


}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithTitle:(NSString*)title andImage:(UIImage*)image andWithType:(int)type andWithDuration:(double)duration inViewController:(UIViewController*)viewController atPostion:(int)position canBeDismissedByUser:(BOOL)canbeDismissedByUser{
    self.title = title;
    self.iconImage = image;
    self.duration = duration;
    self.viewController = viewController;
    self.alertPosition = position;
    
    self = [super initWithFrame:self.frame];

    NSLog(@"%f width",self.frame.size.width);
    // Setup background color and choose icon
    UIImage *imageProvided;
    if (image != nil) {
       imageProvided = image;
    }
    switch (type) {
    case Error:
            self.backgroundColor = [UIColor errorRed];
//        if !imageProvided { self.iconImage = UIImage(named: "errorIcon") }
            if (image == nil) {
                
                self.iconImage = [UIImage imageNamed:@"errorIcon"];
            }
        break;
    case Message:
            self.backgroundColor = [UIColor messageBlue];
//        if !imageProvided { self.iconImage = UIImage(named: "messageIcon") }
            if (image == nil) {
                self.iconImage = [UIImage imageNamed:@"messageIcon"];
            }
            break;
    case Success:
            self.backgroundColor = [UIColor successGreen];
//        if !imageProvided { self.iconImage = UIImage(named: "successIcon") }
            if (image == nil) {
                self.iconImage = [UIImage imageNamed:@"successIcon"];
            }
        break;
    case Warning:
            self.backgroundColor = [UIColor warningYellow];
//        if !imageProvided { self.iconImage = UIImage(named: "warningIcon") }
            if (image == nil) {
                self.iconImage = [UIImage imageNamed:@"warningIcon"];
            }
            break;
    default:
            NSLog(@"Unknown message type provided");
    }
    
    // Setup self
    self.TranslatesAutoresizingMaskIntoConstraints=NO;
    [self setFrame:CGRectMake(0,0,viewController.view.frame.size.width/3,viewController.view.frame.size.width/3)];
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.8;
    self.clipsToBounds = NO;
    
    
    
    // Setup Image View
    self.iconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width * imageViewSize, self.frame.size.width * imageViewSize)];
    self.iconImageView.image = self.iconImage;
    [self.iconImageView setCenter:self.center];
    [self.iconImageView setCenter:CGPointMake(self.iconImageView.center.x,self.iconImageView.center.y - self.iconImageView.frame.size.height * imageViewOffsetFromCentre)];
    [self addSubview:self.iconImageView];
    
    
    
    // Setup Text Label
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.center.x - (self.frame.size.width * titleLabelWidth) / 2, self.iconImageView.frame.origin.y + self.iconImageView.frame.size.height - 5, self.frame.size.width * titleLabelWidth, titleLabelHeight)];
    self.titleLabel.text = title;

    
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    NSLog(@"%f height %f width",self.titleLabel.frame.size.height,self.titleLabel.frame.size.width);

    [self addSubview:self.titleLabel];
    //Position the alert
    [self positionAlertForPosition:position];
    
    if (canbeDismissedByUser) {
        UITapGestureRecognizer *tagGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissAlert)];
        [self addGestureRecognizer:tagGestureRecognizer];
        
    }
    return self;
}

-(void)dismissAlert {
       [[GoogleWearAlertObjc getInstance]removeAlert];
}

-(BOOL) insideNavController{

    if ([self.viewController.parentViewController isKindOfClass:[UINavigationController class]])
    {
        return YES;
    }
    else if ([self.viewController isKindOfClass:[UINavigationController class]])
    {
            return YES;
    }
    
    return NO;
}

//-(void)traitCollectionDidChange:(UITraitCollection)previousTraitCollection{
//    [self layoutSubviews];
//}

-(void)layoutSubviews {
    [super layoutSubviews];
   // [self positionAlertForPosition:position];
}

-(void) positionAlertForPosition:(int)position {
    
    if (UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation)) {
        
        int centerX = self.viewController.view.frame.size.width/2;
        int centerY = self.viewController.view.frame.size.height/2;
        self.center = CGPointMake(centerX, centerY);
        
    } else {
        
        switch (position) {
        case Top:
                self.center = CGPointMake(self.viewController.view.center.x, self.viewController.view.frame.size.height / 4);
            if ([self insideNavController])
                {
                 //   self.center.y += navControllerHeight;
                }
            break;
        case Center:
                self.center = self.viewController.view.center;
            break;
        case Bottom:
                self.center = CGPointMake(self.viewController.view.center.x, self.viewController.view.frame.size.height * 0.75);
            break;
        default:
                NSLog(@"Unknown position type provided");
        }
    }
}

@end
