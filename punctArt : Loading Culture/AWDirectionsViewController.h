//
//  AWDirectionsViewController.h
//  Mall
//
//  Created by vali on 24/08/15.
//  Copyright (c) 2015 mrott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AWDirectionsViewController : UIViewController <CustomNavigationBarDelegate>


@property(nonatomic, strong) NSNumber *latitude;
@property(nonatomic, strong) NSNumber *longitude;
@property(nonatomic) double myLatitude;
@property(nonatomic) double myLongitude;


@end
