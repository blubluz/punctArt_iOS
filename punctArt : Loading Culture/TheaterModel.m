//
//  TheaterModel.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 10/04/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "TheaterModel.h"

@implementation TheaterModel
-(id)initWithDictionary:(NSDictionary *)dictionary{
    self.theaterId = [dictionary safeObjectForKey:@"id"];
    self.name = [dictionary safeObjectForKey:@"name"];
    self.latitude = [dictionary safeObjectForKey:@"latitude"];
    self.longitude = [dictionary safeObjectForKey:@"longitude"];
    return self;
}
@end
