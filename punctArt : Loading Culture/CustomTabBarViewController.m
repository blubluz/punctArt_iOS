//
//  CustomTabBarViewController.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 08/04/17.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "CustomTabBarViewController.h"
#import "ProfileNavigationController.h"
#import "ShowNavigationController.h"
#import "UIViewController+ZooUrban.h"
@interface CustomTabBarViewController ()


@property (weak, nonatomic) IBOutlet UIView *underBar;

//Tab bar screens
@property(strong, nonatomic) ShowNavigationController *showsNav;
@property(strong, nonatomic) ProfileNavigationController *profileNav;

//Current Nav
@property(weak, nonatomic) UINavigationController *currentNav;



@end

@implementation CustomTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showsButtonTapped:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissTabViewControllers
{
    [_profileNav dismissFromParent];
    [_showsNav dismissFromParent];
}
-(ShowNavigationController *)showsNav{
    if(!_showsNav){
        _showsNav = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowNavigationController"];
    }
    return _showsNav;
}
-(ProfileNavigationController *)profileNav{
    if(!_profileNav){
        _profileNav = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileNavigationController"];
    }
    return _profileNav;
}

#pragma mark - Tab Bar Navigation 


- (IBAction)showsButtonTapped:(id)sender {
    [self dismissTabViewControllers];
    if(_currentNav == _showsNav){
        [_currentNav popToRootViewControllerAnimated:YES];
    }
    if(_currentNav&&self.showsNav != _currentNav)
        [self switchTab:_currentNav to:_showsNav];
    _currentNav = self.showsNav;
    [self presentChildViewController:self.showsNav inView:_container animations:nil duration:0 options:UIViewAnimationOptionCurveEaseIn completion:nil];
}
- (IBAction)profileButtonTapped:(id)sender {
    [self dismissTabViewControllers];
    if(_currentNav == _profileNav){
        [_currentNav popToRootViewControllerAnimated:YES];
    }
    if(_currentNav&&self.profileNav != _currentNav)
        [self switchTab:_currentNav to:_profileNav];
    _currentNav = self.profileNav;
    [self presentChildViewController:self.profileNav inView:_container animations:nil duration:0 options:UIViewAnimationOptionCurveEaseIn completion:nil];
}

#pragma mark - Tab Bar Animations

-(void)switchTab:(id)tabToDeselect to:(id)tabToSelect{
    if([tabToSelect isKindOfClass:[ProfileNavigationController class]]){
        [self switchAlphaValueForImage:_profileButtonImageView andLabel:_profileButtonLabel];
        [self moveUnderViewToButton:_profileButton];
    }
    if([tabToSelect isKindOfClass:[ShowNavigationController class]]){
        [self switchAlphaValueForImage:_showButtonImageView andLabel:_showsButtonLabel];
        [self moveUnderViewToButton:_showsButton];
    }
    if([tabToDeselect isKindOfClass:[ProfileNavigationController class]])
        [self switchAlphaValueForImage:_profileButtonImageView andLabel:_profileButtonLabel];
    if([tabToDeselect isKindOfClass:[ShowNavigationController class]])
        [self switchAlphaValueForImage:_showButtonImageView andLabel:_showsButtonLabel];
    
}
-(void)switchAlphaValueForImage:(UIView *)imageView andLabel:(UIView *)label{
    if(imageView.alpha != 1.0)//tab was unselected, select it
        [UIView animateWithDuration:0.3 animations:^{
            imageView.alpha = 1.0;
            label.alpha = 1.0;
        }];
    else //tab was selected, unselect it
        [UIView animateWithDuration:0.3 animations:^{
            imageView.alpha = 0.4;
            label.alpha = 0.4;
        }];
}
-(void)moveUnderViewToButton:(UIButton *)button2{
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //_underBar.frame = CGRectMake(button2.frame.origin.x, _underBar.frame.origin.y, _underBar.frame.size.width, _underBar.frame.size.height);
        self.underBarLeading.constant = button2.frame.origin.x;
        [self.view layoutIfNeeded];
    } completion:nil];
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
