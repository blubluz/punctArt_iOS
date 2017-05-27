//
//  ActorCollectionViewCell.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 26/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActorModel.h"

@interface ActorCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *actorLabel;
@property (strong, nonatomic) ActorModel *actor;

-(void)configureWithActor:(ActorModel *)actor;
@end
