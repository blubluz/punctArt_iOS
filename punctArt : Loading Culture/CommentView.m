//
//  CommentView.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 27/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "CommentView.h"

@implementation CommentView
-(instancetype)init{
    self = [super init];
    self = [[[NSBundle mainBundle] loadNibNamed:@"CommentView" owner:self options:nil] objectAtIndex:0];;
    return self;
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:@"CommentView" owner:self options:nil] objectAtIndex:0];;
    self.frame = frame;
    self.layer.cornerRadius = 0;
    return self;
}
-(void)configureWithComment:(CommentModel *)comment{
    self.authorImage.layer.cornerRadius = 65.0/2.0;
    NSDate *postedDate = comment.createdAt;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:postedDate];
    if(today.year != components.year || today.month!=components.month){
        if(today.year != components.year)
            formatter.dateFormat = @"y d MMMM, HH:mm";
        else
            formatter.dateFormat = @"d MMMM, HH:mm";
        self.dateLabel.text = [formatter stringFromDate:postedDate];
    }else
        if([today day] == [components day]){
            if([today hour] - [components hour]!=0){
                self.dateLabel.text = [NSString stringWithFormat:@"%li hours ago",[today hour] - [components hour]];
            }else{
                if([today minute] - [components minute]>5)
                    self.dateLabel.text = [NSString stringWithFormat:@"%li minutes ago",[today minute]-[components minute]];
                else
                    self.dateLabel.text = @"A few moments ago";
            }
        }
        else if([today day]-1 == [components day]){
            self.dateLabel.text = [NSString stringWithFormat:@"Yesterday, %@",[formatter stringFromDate:postedDate]];
        }else{
            formatter.dateFormat = @"d MMMM, HH:mm";
            self.dateLabel.text = [formatter stringFromDate:postedDate];
            
        }
    
    self.authorLabel.text = [NSString stringWithFormat:@"%@ %@",comment.author.firstName ,comment.author.lastName];
    self.commentLabel.text = comment.commentText;
    [self.commentLabel sizeToFit];
    [self.authorImage sd_setImageWithURL:[NSURL URLWithString:comment.author.photoUrl]];
    
}
-(CGSize)sizeThatFits:(CGSize)size{
    return CGSizeMake(400, self.commentLabel.frame.size.height+40);
}
@end
