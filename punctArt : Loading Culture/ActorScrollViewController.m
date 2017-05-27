//
//  ActorScrollViewController.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 27/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "ActorScrollViewController.h"
#import "ShowsViewController.h"
@interface ActorScrollViewController ()

@end

@implementation ActorScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.actorNameLabel.text = [NSString stringWithFormat:@"%@ %@",_actor.firstName, _actor.lastName];
    self.descriptionLabel.text = self.actor.actorDescription;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)seeShowsTapped:(id)sender {
    ShowsViewController *showsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowsViewController"];
    showsVC.queryString = self.actor.firstName;
    [self.navigationController pushViewController:showsVC animated:YES];
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
