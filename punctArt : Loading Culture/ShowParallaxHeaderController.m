//
//  ShowParallaxHeaderController.m
//  punctArt : Loading Culture
//
//  Created by Honceiru Mihai on 5/15/17.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "ShowParallaxHeaderController.h"
#import <MXParallaxHeader/MXScrollViewController.h>


@interface ShowParallaxHeaderController () <MXParallaxHeaderDelegate>
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UIImageView *playImage;

@end

@implementation ShowParallaxHeaderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parallaxHeader.delegate = self;
    self.overlayView.alpha = 0.17;
    [self.playImage sd_setImageWithURL:[NSURL URLWithString:self.playImagePath]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - <MXParallaxHeaderDelegate>

- (void)parallaxHeaderDidScroll:(MXParallaxHeader *)parallaxHeader {
    self.overlayView.alpha =  MIN((1-parallaxHeader.progress ),1) *0.5 + 0.17;
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
