//
//  ShowsViewController.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 08/04/17.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "ShowsViewController.h"
#import "ShowTableViewCell.h"
@interface ShowsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) UISegmentedControl *titleSegment;
@end

@implementation ShowsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleSegment = [[UISegmentedControl alloc] initWithItems:@[@"Recente" , @"Populare"]];
    [self.titleSegment addTarget:self
                         action:@selector(segmentChanged:)
               forControlEvents:UIControlEventValueChanged];
    self.titleSegment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = self.titleSegment;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ShowTableViewCell" bundle:nil] forCellReuseIdentifier:@"ShowTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShowTableViewCell"];
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
