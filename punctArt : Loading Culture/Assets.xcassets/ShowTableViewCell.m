//
//  ShowTableViewCell.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 08/04/17.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "ShowTableViewCell.h"

@implementation ShowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configureWithPlayRep:(PlayRepresentationModel *)playRep{
    self.playRep = playRep;
    [self.cellImageView sd_setImageWithURL:[NSURL URLWithString:playRep.play.imagePath]];
    self.playTitleLabel.text = playRep.play.playName;
    if(playRep.theater)
        self.theaterNameLabel.text = playRep.theater.name;
    else{
        self.theaterNameLabel.hidden = YES;
        self.theaterIcon.hidden = YES;
        
    }
    if(self.playRep.date){
    NSDateFormatter *prettyDateFormatter = [[NSDateFormatter alloc] init];
    prettyDateFormatter.dateFormat = @"EEEE, MMM d";
    
    NSDateComponents *currentComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:playRep.date];
    
    
    
        if(currentComponents.day == dateComponents.day ){
            prettyDateFormatter.dateFormat = @"hh:mm";
            self.dateLabel.text = [NSString stringWithFormat:@"Azi, %@",[prettyDateFormatter stringFromDate:playRep.date]];
        }
        else
            if (currentComponents.day == dateComponents.day+1) {
                prettyDateFormatter.dateFormat = @"hh:mm";
                self.dateLabel.text = [NSString stringWithFormat:@"Mâine, %@",[prettyDateFormatter stringFromDate:playRep.date]];
            }
        else{
            prettyDateFormatter.dateFormat = @"EEEE,d MMM, hh:mm";
            self.dateLabel.text = [NSString stringWithFormat:@"%@",[prettyDateFormatter stringFromDate:playRep.date]];
        }
    }else{
        self.dateLabel.hidden = YES;
        self.dateIcon.hidden = YES;
        
    }
    
}
-(void)prepareForReuse{
    self.dateLabel.text = @"-";
    self.cellImageView.image = nil;
    self.theaterNameLabel.text = @"-";
}
- (IBAction)moreOptionsButtonTapped:(id)sender {
    if([self.delegate respondsToSelector:@selector(moreOptionsTappedForPlayRep:atIndexPath:)]){
        [self.delegate moreOptionsTappedForPlayRep:self.playRep atIndexPath:self.indexPath] ;
    }
}
- (IBAction)locationButtonTapped:(id)sender {
    if(!self.playRep.theater)
        return;
    if([self.delegate respondsToSelector:@selector(locationTappedForPlayRep:)]){
        [self.delegate locationTappedForPlayRep:self.playRep];
    }
}
@end
