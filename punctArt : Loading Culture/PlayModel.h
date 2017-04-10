//
//  PlayModel.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 10/04/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayModel : NSObject
@property(strong, nonatomic) NSNumber *playId;
@property(strong, nonatomic) NSString *playName;
@property(strong, nonatomic) NSString *playDescription;
@property(strong, nonatomic) NSString *imagePath;
@property(strong, nonatomic) NSString *category;
@property(strong, nonatomic) NSNumber *rating;
-(id)initWithDictionary:(NSDictionary *)dictionary;
@end