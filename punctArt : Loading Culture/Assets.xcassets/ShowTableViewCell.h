//
//  ShowTableViewCell.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 08/04/17.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayRepresentationModel.h"
@protocol ShowTableViewDelegate <NSObject>
-(void)locationTappedForPlayRep:(PlayRepresentationModel *)playRep;
-(void)moreOptionsTappedForPlayRep:(PlayRepresentationModel *)playRep atIndexPath:(NSIndexPath *)indexPath;

@end
@interface ShowTableViewCell : UITableViewCell
-(void)configureWithPlayRep:(PlayRepresentationModel *)playRep;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *theaterNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTitleLabel;
@property (weak, nonatomic) id<ShowTableViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *optionsButton;
@property (weak, nonatomic) IBOutlet UIImageView *dateIcon;
@property (weak, nonatomic) IBOutlet UIImageView *theaterIcon;
@property (weak, nonatomic) PlayRepresentationModel *playRep;
@property (strong, nonatomic) NSIndexPath *indexPath;
@end
