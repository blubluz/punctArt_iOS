//
//  ProfileViewController.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 25/04/17.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "ProfileViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "CustomTabBarViewController.h"
#import "ShowsViewController.h"
@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource, LoginControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.profileImageView.layer.cornerRadius = 8;
   
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    if(![FBSDKAccessToken currentAccessToken]){
        LoginViewController *loginVc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        loginVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        loginVc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        loginVc.delegate = self;
        //Bad implementation - Must create superclass with pointer to CustomTabBar.
        [self presentViewController:loginVc animated:YES completion:nil];
    }else{
        LoggedUser *loggedUser = [LoggedUser loadUser];
        if(loggedUser){
            [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:loggedUser.photoUrl]];
            self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",loggedUser.lastName, loggedUser.firstName];
            self.emailLabel.hidden = YES;
        }
    }
}
#pragma mark - LoginControllerDelegate
-(void)closeButtonTapped{
    
    //Bad implementation - Must create superclass with pointer to CustomTabBar.
    if([self.parentViewController.parentViewController isKindOfClass:[CustomTabBarViewController class]]){
        CustomTabBarViewController *tabBar = (CustomTabBarViewController *)self.parentViewController.parentViewController;
        [tabBar.showsButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void)succesfulyLoggedIn{
    LoggedUser *loggedUser = [LoggedUser loadUser];
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:loggedUser.photoUrl]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",loggedUser.lastName, loggedUser.firstName];
    self.emailLabel.hidden = YES;
}
#pragma mark - TableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        ShowsViewController *pageContent = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowsViewController"];
        CategoryModel *category = [[CategoryModel alloc] init];
        category.categoryName = @"favorite";
        pageContent.category = category;
        [self.navigationController pushViewController:pageContent animated:YES];

    }
    if(indexPath.section == 1){
        self.profileImageView.image = nil;
        self.nameLabel.text = @"Nume";
        [LoggedUser deleteUser];
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logOut];
        LoginViewController *loginVc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        loginVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        loginVc.delegate = self;
        dispatch_async (dispatch_get_main_queue(), ^{
            [self presentViewController:loginVc animated:YES completion:nil];
        });
    }
}
#pragma mark - TableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if(indexPath.section==0)
    {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"ProfileTableViewCell"];
    }
    else{
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"LogoutTableViewCell"];
    }
    return cell;
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
