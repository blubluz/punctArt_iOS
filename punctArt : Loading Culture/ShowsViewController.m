//
//  ShowsViewController.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 08/04/17.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "ShowsViewController.h"
#import "ShowTableViewCell.h"
#import "PlayRepresentationModel.h"
#import "GetPlayRepresRequest.h"
#import "LocationMapViewController.h"
#import "ShowViewController.h"
#import "GetFavoritesRequest.h"
#import "PostFavoriteRequest.h"
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "LoginViewController.h"
@interface ShowsViewController () <UITableViewDelegate, UITableViewDataSource,ShowTableViewDelegate,FBSDKSharingDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *noShowsLabel;
@property(strong, nonatomic) NSMutableArray<PlayRepresentationModel *> *playReps;
@end

@implementation ShowsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ShowTableViewCell" bundle:nil] forCellReuseIdentifier:@"ShowTableViewCell"];
    self.playReps = [[NSMutableArray alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIRefreshControl *refreshController = [[UIRefreshControl alloc] init];
    [refreshController addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refreshController;
    
   
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
}
-(void)loadData{
    GetPlayRepresRequest *request = [[GetPlayRepresRequest alloc] init];
    if([self.category.categoryName isEqualToString:@"favorite"]){
        [[HttpClient sharedHTTPClient] performRequest:[[GetFavoritesRequest alloc] init] WithResponse:^(BaseResponse *response, NSError *error) {
            [self.tableView.refreshControl endRefreshing];
            GetFavoritesResponse *repResp = (GetFavoritesResponse *)response;
            NSMutableArray<PlayRepresentationModel *> *playReps =[[NSMutableArray alloc] init];
            for(PlayModel *playModel in repResp.plays){
                PlayRepresentationModel *playRep = [[PlayRepresentationModel alloc] init];
                playRep.play = playModel;
                [playReps addObject:playRep];
            }
            self.playReps = playReps;
            if(self.playReps.count!=0){
                self.noShowsLabel.hidden = YES;
            }
            else self.noShowsLabel.hidden = NO;
            [self.tableView reloadData];
        }];
        return;
    }
    if(self.queryString)
        request.searchQuery = self.queryString;
    if(![self.category.categoryName isEqualToString:@"Toate"])
        request.categoryId = self.category.categoryId;
    if(self.orderType)
        request.orderType = self.orderType;
    [[HttpClient sharedHTTPClient] performRequest:request WithResponse:^(BaseResponse *response, NSError *error) {
        [self.tableView.refreshControl endRefreshing];
        GetPlayRepresResponse *repResp = (GetPlayRepresResponse *)response;
        if(self.playReps.count!=0){
            self.noShowsLabel.hidden = YES;
        }
        else
            self.noShowsLabel.hidden = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.playReps = [repResp.playReps mutableCopy];
            [self.tableView reloadData];
        });
    }];
}



#pragma mark - TableView Delegate/DataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 145;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.playReps)
        return self.playReps.count;
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShowTableViewCell"];
    [cell configureWithPlayRep:self.playReps[indexPath.row]];
    cell.delegate = self;
    cell.indexPath = indexPath;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.playReps[indexPath.row].theater){
        [self performSegueWithIdentifier:@"goToShow" sender:indexPath];
    }else{
        ShowsViewController *pageContent = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowsViewController"];
        pageContent.queryString = self.playReps[indexPath.row].play.playName;
        [self.navigationController pushViewController:pageContent animated:YES];
    }
}
-(void)locationTappedForPlayRep:(PlayRepresentationModel *)playRep{
    NSLog(@"Location tapped");
    LocationMapViewController *locationVc = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationMapViewController"];
    locationVc.theater = playRep.theater;
    [self.navigationController pushViewController:locationVc animated:YES];
}

-(void)moreOptionsTappedForPlayRep:(PlayRepresentationModel *)playRep atIndexPath:(NSIndexPath *)indexPath{
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

    UIAlertAction *addToFavoritesButton = [UIAlertAction actionWithTitle:playRep.play.isFavorite?@"Scoate de la favorite":@"Adaugă la favorite" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
        [[HttpClient sharedHTTPClient] performRequest:[[PostFavoriteRequest alloc] initWithPlayId:playRep.play.playId andIsFav:!playRep.play.isFavorite] WithResponse:^(BaseResponse *response, NSError *error) {
            
            [SVProgressHUD showSuccessWithStatus:!playRep.play.isFavorite?@"Adăugat cu succes":@"Scos de la favorite"];
            if(playRep.play.isFavorite&&!playRep.theater){
                
                
                [self.playReps removeObject:playRep];
                
                [self.tableView beginUpdates];
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
                [self.tableView endUpdates];
                [self.tableView reloadData];
            }
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

-(void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error{
    
}
-(void)sharerDidCancel:(id<FBSDKSharing>)sharer{
    
}
-(void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"goToShow"]){
        NSIndexPath *selectedPlayIndex = (NSIndexPath *)sender;
        PlayRepresentationModel *selectedPlay = [self.playReps objectAtIndex:selectedPlayIndex.row];
        ShowViewController *destination = (ShowViewController *)segue.destinationViewController;
        destination.playRep = selectedPlay;
    }
}


@end
