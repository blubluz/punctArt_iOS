//
//  CommentView.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 27/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
@interface CommentView : UIView
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *authorImage;
-(void)configureWithComment:(CommentModel *)comment;
@end
