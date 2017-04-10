//
//  ActorModel.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 10/04/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActorModel : NSObject
@property(strong, nonatomic) NSNumber *actorId;
@property(strong, nonatomic) NSString *firstName;
@property(strong, nonatomic) NSString *lastName;
@property(strong, nonatomic) NSString *profilePictureUrl;
@property(strong, nonatomic) NSString *actorDescription;
-(id)initWithDictionary:(NSDictionary *)dict;
@end
