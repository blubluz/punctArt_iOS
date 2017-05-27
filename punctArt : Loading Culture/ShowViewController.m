//
//  ShowViewController.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 26/04/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "ShowViewController.h"
#import "ShowParallaxHeaderController.h"
#import "ShowScrollViewController.h"
#import "PostFavoriteRequest.h"
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "LoginViewController.h"
@interface ShowViewController () <FBSDKSharingDelegate>

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *transparentPixel = [UIImage imageNamed:@"transparent_pixel"];
    [self.navigationController.navigationBar setBackgroundImage:transparentPixel forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = transparentPixel;
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"..." style:UIBarButtonItemStyleDone target:self action:@selector(optionButtonTapped)];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}
-(void)optionButtonTapped{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *shareButton = [UIAlertAction actionWithTitle:@"Share" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // Example content. Replace with content from your app.
        FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
        content.contentURL = [NSURL URLWithString:@"http://www.punctart.ro"];
        
        FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fbauth2://"]]){
            dialog.mode = FBSDKShareDialogModeNative;
        }
        else {
            dialog.mode = FBSDKShareDialogModeBrowser; //or FBSDKShareDialogModeAutomatic
        }
        dialog.shareContent = content;
        dialog.delegate = self;
        dialog.fromViewController = self;
        [dialog show];
    }];
    UIAlertAction *addToFavoritesButton = [UIAlertAction actionWithTitle:self.playRep.play.isFavorite?@"Scoate de la favorite":@"Adaugă la favorite" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(![LoggedUser loadUser]){
            LoginViewController *loginVc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            loginVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            loginVc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            //        loginVc.delegate = self;
            //Bad implementation - Must create superclass with pointer to CustomTabBar.
            [self presentViewController:loginVc animated:YES completion:nil];
            return;
        }
        [SVProgressHUD show];
        [[HttpClient sharedHTTPClient] performRequest:[[PostFavoriteRequest alloc] initWithPlayId:self.playRep.play.playId andIsFav:!self.playRep.play.isFavorite] WithResponse:^(BaseResponse *response, NSError *error) {
            [SVProgressHUD showSuccessWithStatus:!self.playRep.play.isFavorite?@"Adăugat cu succes":@"Scos de la favorite"];
            self.playRep.play.isFavorite = NO;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }];
    }];
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Închide" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:shareButton];
    [alertController addAction:addToFavoritesButton];
    [alertController addAction:cancelButton];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results{
    
}
-(void)sharerDidCancel:(id<FBSDKSharing>)sharer{
    
}
-(void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"parallax_header"]){
        ShowParallaxHeaderController *header = (ShowParallaxHeaderController *) segue.destinationViewController;
        header.playImagePath = self.playRep.play.imagePath;
    }else{
        ShowScrollViewController *scrollController = (ShowScrollViewController *) segue.destinationViewController;
        scrollController.playRep = self.playRep;
    }
}


@end
