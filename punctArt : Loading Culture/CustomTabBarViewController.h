//
//  CustomTabBarViewController.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 08/04/17.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBarViewController : UIViewController

//Tab Bar Buttons
@property (weak, nonatomic) IBOutlet UIButton *showsButton;
@property (weak, nonatomic) IBOutlet UIButton *profileButton;


//Tab Bar Buttons Labels
@property (weak, nonatomic) IBOutlet UILabel *showsButtonLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileButtonLabel;


//Tab Bar Buttons Image Views
@property (weak, nonatomic) IBOutlet UIImageView *showButtonImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileButtonImageView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *underBarLeading;
@property (weak, nonatomic) IBOutlet UIView *container;


-(void) presentSubview:(UIView *)view;
-(void) removeSubview:(UIView *)view;

@end
