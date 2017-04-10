//
//  PlayRepresentationModel.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 10/04/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "PlayRepresentationModel.h"

@implementation PlayRepresentationModel
-(id)initWithDictionary:(NSDictionary *)dictionary{
    self.representationId = [dictionary safeObjectForKey:@"id"];
    NSString *dateString = [dictionary safeObjectForKey:@"date"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    self.date = [dateFormatter dateFromString:dateString];
    self.theater = [[TheaterModel alloc] initWithDictionary:[dictionary safeObjectForKey:@"theater"]];
    self.play = [[PlayModel alloc] initWithDictionary:[dictionary safeObjectForKey:@"play"]];
    self.actor = [NSArray arrayWithObjectClass:[ActorModel class] andSource:[dictionary safeObjectForKey:@"actors"]];
    return self;
}
@end
