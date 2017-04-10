//
//  TheaterModel.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 10/04/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TheaterModel : NSObject
@property(strong,nonatomic) NSNumber *theaterId;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSNumber *latitude;
@property(strong,nonatomic) NSNumber *longitude;

-(id)initWithDictionary:(NSDictionary *)dictionary;
@end
