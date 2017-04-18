//
//  AWDirectionsViewController.m
//  Mall
//
//  Created by vali on 24/08/15.
//  Copyright (c) 2015 mrott. All rights reserved.
//

#import "AWDirectionsViewController.h"

@interface AWDirectionsViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation AWDirectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSString *googleMapsUrlString = [NSString stringWithFormat:@"http://maps.google.com/?saddr=%f,%f&daddr=%@,%@", _myLatitude, _myLongitude, self.latitude, self.longitude];
    
    NSURL *googleMapsURL = [NSURL URLWithString:googleMapsUrlString];

    [self.webView loadRequest:[NSURLRequest requestWithURL:googleMapsURL]];
}


-(void)backButtonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
