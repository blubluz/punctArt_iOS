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
    return self;
}
@end
