//
//  ShowViewController.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 26/04/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "ShowViewController.h"

@interface ShowViewController ()

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *transparentPixel = [UIImage imageNamed:@"transparent_pixel"];
    [self.navigationController.navigationBar setBackgroundImage:transparentPixel forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = transparentPixel;
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
