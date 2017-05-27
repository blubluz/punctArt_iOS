//
//  ActorScrollViewController.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 27/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActorModel.h"

@interface ActorScrollViewController : UIViewController
@property(strong, nonatomic) ActorModel *actor;
@property (weak, nonatomic) IBOutlet UILabel *actorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
