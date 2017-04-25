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
@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    if(![FBSDKAccessToken currentAccessToken]){
        LoginViewController *loginVc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        loginVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:loginVc animated:YES completion:nil];
    }
}
#pragma mark - TableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logOut];
        LoginViewController *loginVc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        loginVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:loginVc animated:YES completion:nil];
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
    return 15;
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
