//
//  ShowsViewController.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 08/04/17.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"

@interface ShowsViewController : UIViewController
@property(strong, nonatomic) CategoryModel *category;
@property(strong, nonatomic) NSString *queryString;
@property(strong, nonatomic) NSString *orderType;
-(void)loadData;
@end
