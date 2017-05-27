//
//  ActorParallaxViewController.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 27/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "ActorParallaxViewController.h"
#import <MXParallaxHeader/MXScrollViewController.h>

@interface ActorParallaxViewController () <MXParallaxHeaderDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;

@end

@implementation ActorParallaxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parallaxHeader.delegate = self;
    self.overlayView.alpha = 0.17;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.actorImagePath]];
    
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
