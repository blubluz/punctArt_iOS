//
//  LoginViewController.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 25/04/17.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "LoginViewController.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "LoginRequest.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *fbLoginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *beView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    beView.frame = self.view.bounds;
    beView.userInteractionEnabled = YES;
    self.view.frame = self.view.bounds;
    self.view.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:beView atIndex:0];
    
}
- (IBAction)closeButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)loginButtonTapped:(id)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];
    self.fbLoginButton.enabled = NO;
    if ([UIApplication.sharedApplication canOpenURL:[NSURL URLWithString:@"fb://"]])
    {
        login.loginBehavior = FBSDKLoginBehaviorSystemAccount;
    }
    
    [login logInWithReadPermissions:@[@"public_profile", @"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error)
        {
            self.fbLoginButton.enabled = YES;
            NSLog(@"Unexpected login error: %@", error);
            NSString *alertMessage = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?: @"There was a problem logging in. Please try again.";
            NSString *alertTitle = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Oops";
            
            [AlertManager presentSimpleAlertWithMessage:alertMessage andTitle:alertTitle inViewController:self];
        }
        else
        {
            [[HttpClient sharedHTTPClient] performRequest:[[LoginRequest alloc] initWithToken:[FBSDKAccessToken currentAccessToken].tokenString andPlatform:Facebook] WithResponse:^(BaseResponse *response, NSError *error) {
                if(!error){
                    if(!response.error){
                        
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }
                    else
                        [AlertManager presentSimpleAlertWithMessage:response.errorDescription andTitle:@"Error" inViewController:self];
                }
                else{
                    [AlertManager presentSimpleAlertWithMessage:error.localizedDescription andTitle:@"Oops" inViewController:self];
                }
            }];
        }
    }];
    
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
