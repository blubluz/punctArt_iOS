//
//  ActorViewController.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 27/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "ActorViewController.h"
#import "ActorParallaxViewController.h"
#import "ActorScrollViewController.h"
@interface ActorViewController ()

@end

@implementation ActorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *transparentPixel = [UIImage imageNamed:@"transparent_pixel"];
    [self.navigationController.navigationBar setBackgroundImage:transparentPixel forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = transparentPixel;
    //    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setTranslucent:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"parallax_header2"]){
        ActorParallaxViewController *header = (ActorParallaxViewController *) segue.destinationViewController;
        header.actorImagePath = self.actor.profilePictureUrl;
    }else{
        ActorScrollViewController *scrollController = (ActorScrollViewController *) segue.destinationViewController;
        scrollController.actor = self.actor;
    }
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
