//
//  ShowScrollViewController.m
//  punctArt : Loading Culture
//
//  Created by Honceiru Mihai on 5/15/17.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "ShowScrollViewController.h"
#import "ActorCollectionViewCell.h"
#import "LocationMapViewController.h"
#import "PostCommentRequest.h"
#import "CommentView.h"
#import "ActorViewController.h"
#import "LoginViewController.h"
@interface ShowScrollViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *playNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContraint;
@property (weak, nonatomic) IBOutlet UILabel *noCommentsLabel;

@end

@implementation ShowScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.actorsCollectionView.delegate = self;
    self.actorsCollectionView.dataSource = self;
    [self.actorsCollectionView registerNib:[UINib nibWithNibName:@"ActorCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ActorCollectionViewCell"];

    self.playNameLabel.text = self.playRep.play.playName;
    self.descriptionLabel.text = self.playRep.play.playDescription;
    [self.descriptionLabel sizeToFit];
    NSInteger height = 0;
    if(self.playRep.play.comments.count==0)
        self.noCommentsLabel.hidden = NO;
    else
        self.noCommentsLabel.hidden = YES;
    for(CommentModel *comment in self.playRep.play.comments){
        CommentView *commentView = [[CommentView alloc] init];
        [commentView configureWithComment:comment];
        
//        [commentView sizeToFit];
        height += commentView.frame.size.height;
        [self.stackView addArrangedSubview:commentView];
    }
    self.heightContraint.constant = height;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.commentTextField resignFirstResponder];
    [self.commentTextField endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addCommentButtonTapped:(id)sender {
    [self.commentTextField resignFirstResponder];
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
    if([self.commentTextField.text isEqualToString:@""]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Comentariul nu poate fi gol" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction: ok];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    [[HttpClient sharedHTTPClient] performRequest:[[PostCommentRequest alloc] initWithCommentText:self.commentTextField.text andPlayId:self.playRep.play.playId] WithResponse:^(BaseResponse *response, NSError *error) {
        self.noCommentsLabel.hidden = YES;
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"Comentariu adaugat"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        CommentModel *comment = [[CommentModel alloc] init];
        comment.commentText = self.commentTextField.text;
        comment.author = [LoggedUser loadUser];
        comment.createdAt = [NSDate date];
        CommentView *commentView = [[CommentView alloc] init];
        [commentView configureWithComment:comment];
        NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self.playRep.play.comments];
        [mutableArray addObject:comment];
        self.playRep.play.comments = mutableArray;
//        [commentView sizeToFit];
        [self.stackView addArrangedSubview:commentView];
        self.heightContraint.constant = self.heightContraint.constant + commentView.frame.size.height;
        self.commentTextField.text = @"";
    }];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (IBAction)directionsTapped:(id)sender {
    NSLog(@"Location tapped");
    LocationMapViewController *locationVc = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationMapViewController"];
    locationVc.theater = self.playRep.theater;
    [self.navigationController pushViewController:locationVc animated:YES];

}
- (IBAction)buyTicketsTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.punctart.ro"]];

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.playRep.actors.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ActorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ActorCollectionViewCell" forIndexPath:indexPath];
    [cell configureWithActor:self.playRep.actors[indexPath.row]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ActorViewController *actorVc = [self.storyboard instantiateViewControllerWithIdentifier:@"ActorViewController"];
    actorVc.actor = self.playRep.actors[indexPath.row];
    [self.navigationController pushViewController:actorVc animated:YES];
}




@end
