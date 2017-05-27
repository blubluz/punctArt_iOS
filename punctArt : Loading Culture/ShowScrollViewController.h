//
//  ShowScrollViewController.h
//  punctArt : Loading Culture
//
//  Created by Honceiru Mihai on 5/15/17.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayRepresentationModel.h"
@interface ShowScrollViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *actorsCollectionView;
@property (strong, nonatomic) PlayRepresentationModel *playRep;
@end
