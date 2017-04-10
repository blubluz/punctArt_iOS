//
//  LocationMapViewController.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 10/04/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "LocationMapViewController.h"

@interface LocationMapViewController ()<GMSMapViewDelegate, CLLocationManagerDelegate>

@property(nonatomic) CLLocationManager *locationManager;
@property(nonatomic, strong) NSMutableArray *markers;
@property(nonatomic, strong) GMSMarker *meMarker;
@property CLLocationCoordinate2D position;


@end

@implementation LocationMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (nil == _locationManager)
        _locationManager = [[CLLocationManager alloc] init];
    
    _locationManager.delegate = self;
    //Configure Accuracy depending on your needs, default is kCLLocationAccuracyBest
    _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    _locationManager.distanceFilter = 500; // meters
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self.locationManager requestWhenInUseAuthorization];
    
    [_locationManager startUpdatingLocation];
    
    [self configureMap];
    [self configureMarker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)configureMarker{
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(self.theater.latitude.floatValue, self.theater.longitude.floatValue);
    
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.title = [NSString stringWithFormat:@"%@",self.theater.name];
    marker.map = self.mapView;
    self.mapView.selectedMarker = marker;
}
- (void) configureMap
{
    
    //TODO comment this line
    //self.position = CLLocationCoordinate2DMake(44.25f, 26.26f);
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.theater.latitude.floatValue
                                                            longitude:self.theater.longitude.floatValue
                                                                 zoom:12];
    
    //GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView.myLocationEnabled = YES;
    self.mapView.camera = camera;
    self.mapView.delegate = self;
    self.mapView.accessibilityElementsHidden = NO;
    
    self.meMarker = [GMSMarker markerWithPosition:self.position];
    
    self.meMarker.map = self.mapView;
    
    //self.view = mapView;
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
   /* CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (fabs(howRecent) < 15.0) {
        self.position = location.coordinate;
        self.meMarker.position = location.coordinate;
        
    }*/
}

/*
 #pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
