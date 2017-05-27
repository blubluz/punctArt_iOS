//
//  ActorCollectionViewCell.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 26/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "ActorCollectionViewCell.h"

@implementation ActorCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cellImage.layer.cornerRadius = 35;
    // Initialization code
}
-(void)configureWithActor:(ActorModel *)actor{
    [self.cellImage sd_setImageWithURL:[NSURL URLWithString:actor.profilePictureUrl]];
    self.actorLabel.text = [NSString stringWithFormat:@"%@ %@",actor.firstName,actor.lastName];
    self.actor = actor;
}
@end
