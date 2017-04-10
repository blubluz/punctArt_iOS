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
@interface ShowsViewController () <UITableViewDelegate, UITableViewDataSource,ShowTableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) UISegmentedControl *titleSegment;
@property(strong, nonatomic) NSArray<PlayRepresentationModel *> *playReps;
@end

@implementation ShowsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleSegment = [[UISegmentedControl alloc] initWithItems:@[@"Recente" , @"Populare"]];
    self.titleSegment.tintColor = [UIColor blackColor];
    [self.titleSegment addTarget:self
                         action:@selector(segmentChanged:)
               forControlEvents:UIControlEventValueChanged];
    self.titleSegment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = self.titleSegment;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ShowTableViewCell" bundle:nil] forCellReuseIdentifier:@"ShowTableViewCell"];
    self.playReps = [[NSArray alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIRefreshControl *refreshController = [[UIRefreshControl alloc] init];
    [refreshController addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refreshController;
    [self loadData];
    
   
    
}
-(void)loadData{
    [[HttpClient sharedHTTPClient] performRequest:[[GetPlayRepresRequest alloc] init] WithResponse:^(BaseResponse *response, NSError *error) {
        [self.tableView.refreshControl endRefreshing];
        GetPlayRepresResponse *repResp = (GetPlayRepresResponse *)response;
        self.playReps = repResp.playReps;
        [self.tableView reloadData];
    }];
}
-(void)segmentChanged:(id)sender{
    if(self.titleSegment.selectedSegmentIndex == 0)
        NSLog(@"Recente");
    else
        NSLog(@"Populare");
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
    return cell;
}
-(void)locationTappedForPlayRep:(PlayRepresentationModel *)playRep{
    NSLog(@"Location tapped");
    LocationMapViewController *locationVc = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationMapViewController"];
    locationVc.theater = playRep.theater;
    [self.navigationController pushViewController:locationVc animated:YES];
}
-(void)moreOptionsTappedForPlayRep:(PlayRepresentationModel *)playRep{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *shareButton = [UIAlertAction actionWithTitle:@"Share" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *addToCalendarButton = [UIAlertAction actionWithTitle:@"Adaugă la calendar" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *addToFavoritesButton = [UIAlertAction actionWithTitle:@"Adaugă la favorite" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Închide" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:shareButton];
    [alertController addAction:addToCalendarButton];
    [alertController addAction:addToFavoritesButton];
    [alertController addAction:cancelButton];
    [self presentViewController:alertController animated:YES completion:nil];
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
