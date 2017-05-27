//
//  ShowViewController.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 26/04/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MXParallaxHeader/MXParallaxHeader.h>
#import <MXParallaxHeader/MXScrollViewController.h>
#import "PlayRepresentationModel.h"
@interface ShowViewController : MXScrollViewController
@property(strong, nonatomic) PlayRepresentationModel *playRep;
@end
