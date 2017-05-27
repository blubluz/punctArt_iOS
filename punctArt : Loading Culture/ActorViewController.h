//
//  ActorViewController.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 27/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//


#import <MXParallaxHeader/MXParallaxHeader.h>
#import <MXParallaxHeader/MXScrollViewController.h>
#import "ActorModel.h"
@interface ActorViewController : MXScrollViewController
@property(strong, nonatomic) ActorModel *actor;
@end
