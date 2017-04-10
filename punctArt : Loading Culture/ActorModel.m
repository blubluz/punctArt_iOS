//
//  ActorModel.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 10/04/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "ActorModel.h"

@implementation ActorModel

-(id)initWithDictionary:(NSDictionary *)dict{
    self.actorId = [dict safeObjectForKey:@"id"];
    self.firstName = [dict safeObjectForKey:@"first_name"];
    self.lastName = [dict safeObjectForKey:@"last_name"];
    self.actorDescription = [dict safeObjectForKey:@"description"];
    self.profilePictureUrl = [dict safeObjectForKey:@"profile_picture"];
    return self;
}

@end
