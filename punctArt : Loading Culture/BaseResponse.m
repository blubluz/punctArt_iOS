//
//  BaseResponse.m
//  Liga Ultrass
//
//  Created by Mihaih on 01/11/16.
//  Copyright © 2015 Toma Andrei. All rights reserved.
//

#import "BaseResponse.h"
#import "AppDelegate.h"
@implementation BaseResponse

-(id)initWithDictionary:(NSDictionary*)dict
{
    if (self = [super init])
    {
        self.message = [dict safeObjectForKey:@"message"];
        self.errorMessage = [dict safeStringForKey:@"error"];
        self.type = [dict safeStringForKey:@"type"];
    }
    return self;
}
-(id)initWithArray:(NSArray *)array{
    if (self = [super init]){
        
    }
    return self;
}
@end
