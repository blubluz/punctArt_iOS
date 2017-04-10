//
//  LocationMapViewController.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 10/04/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheaterModel.h"
#import <GoogleMaps/GoogleMaps.h>
@interface LocationMapViewController : UIViewController
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property(strong, nonatomic) TheaterModel *theater;
@end
