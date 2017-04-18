//
//  AWDirectionsViewController.m
//  Mall
//
//  Created by vali on 24/08/15.
//  Copyright (c) 2015 mrott. All rights reserved.
//

#import "AppearanceUtils.h"
#import "AWDirectionsViewController.h"

@interface AWDirectionsViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) CustomNavigationBar *customNav;

@end

@implementation AWDirectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSString *googleMapsUrlString = [NSString stringWithFormat:@"http://maps.google.com/?saddr=%f,%f&daddr=%@,%@", _myLatitude, _myLongitude, self.latitude, self.longitude];
    
    NSURL *googleMapsURL = [NSURL URLWithString:googleMapsUrlString];

    [self.webView loadRequest:[NSURLRequest requestWithURL:googleMapsURL]];
    [self initNavigationBar];
}


-(void)initNavigationBar{
    _customNav = [[CustomNavigationBar alloc] init];
    [_customNav setTransparentBarWithTitle:@"DIRECTIONS" andMall:nil backButton:YES searchButton:NO infoButton:NO downArrow:NO];
    [_customNav.titleLabel setTextColor:[UIColor whiteColor]];
    _customNav.delegate = self;
    [self.view addSubviewWithFitConstraints:_customNav];
}
-(void)backButtonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
