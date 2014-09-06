//
//  UIColor+Alert.m
//  Alert
//
//  Created by binaryboy on 9/5/14.
//  Copyright (c) 2014 AhmedHamdy. All rights reserved.
//

#import "UIColor+Alert.h"

@implementation UIColor (Alert)
+(UIColor*)successGreen{
    //return UIColor( 69.0/255.0,  181.0/255.0, 38.0/255.0,  1);
    return  [UIColor colorWithRed:69.0/255.0 green:181.0/255.0 blue:38.0/255.0 alpha:1];

}
+(UIColor*)errorRed  {
  return  [UIColor colorWithRed:255.0/255.0 green:82.0/255.0 blue:82.0/255.0 alpha:1];
}
+(UIColor*)warningYellow  {
    //return UIColor( 255.0/255.0,  205.0/255.0, 64.0/255.0,  1);
    return  [UIColor colorWithRed:255.0/255.0 green:205.0/255.0 blue:64.0/255.0 alpha:1];


}
+(UIColor*)messageBlue  {
    //return UIColor( 2.0/255.0,  169.0/255.0, 244.0/255.0,  1);
    return  [UIColor colorWithRed:2.0/255.0 green:169.0/255.0 blue:244.0/255.0 alpha:1];
    
    
    
}

@end
