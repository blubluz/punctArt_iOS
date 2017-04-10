//
//  BaseResponse.h
//  Liga Ultrass
//
//  Created by Mihaih on 01/11/16.
//  Copyright © 2015 Toma Andrei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseResponse : NSObject



@property (nonatomic) BOOL success;
@property (strong, nonatomic) NSString *errorMessage;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *message;

-(id)initWithDictionary:(NSDictionary*)dict;
-(id)initWithArray:(NSArray *)array;


@end
