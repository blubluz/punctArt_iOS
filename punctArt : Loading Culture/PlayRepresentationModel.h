//
//  PlayRepresentationModel.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 10/04/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TheaterModel.h"
#import "PlayModel.h"
#import "ActorModel.h"
@interface PlayRepresentationModel : NSObject
@property(strong, nonatomic) NSNumber *representationId;
@property(strong, nonatomic) NSDate *date;
@property(strong, nonatomic) TheaterModel *theater;
@property(strong, nonatomic) PlayModel *play;
@property(strong, nonatomic) NSArray<ActorModel *> *actors;
-(id)initWithDictionary:(NSDictionary *)dictionary;
@end
