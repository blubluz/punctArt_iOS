//
//  LoginViewController.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 25/04/17.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginControllerDelegate <NSObject>
-(void)closeButtonTapped;
@end
@interface LoginViewController : UIViewController
@property(weak, nonatomic) id<LoginControllerDelegate> delegate;
@end
