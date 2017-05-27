//
//  PlayModel.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 10/04/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "PlayModel.h"

@implementation PlayModel

-(id)initWithDictionary:(NSDictionary *)dictionary{
    self.playId = [dictionary safeObjectForKey:@"id"];
    self.playName = [dictionary safeObjectForKey:@"name"];
    self.playDescription = [dictionary safeObjectForKey:@"description"];
    self.imagePath = [dictionary safeObjectForKey:@"image_paths"];
    self.category = [dictionary safeObjectForKey:@"category"];
    self.rating = [dictionary safeObjectForKey:@"rating"];
    self.trailerLink = [dictionary safeObjectForKey:@"trailer_link"];
    NSArray *commentsArray = [dictionary safeObjectForKey:@"comments"];
    NSMutableArray *comments = [[NSMutableArray alloc] init];
    for(NSDictionary *dict in commentsArray){
        CommentModel *comment = [[CommentModel alloc] initWithDictionary:dict];
        [comments addObject:comment];
    }
    if([dictionary safeObjectForKey:@"auth_user_favorite"]){
        self.isFavorite = YES;
    }
    self.comments = [NSArray arrayWithArray:comments];
    return self;
}
@end
