//
//  Session.m
//  Liga Ultrass
//
//  Created by Mihai Honceriu on 21/11/16.
//  Copyright © 2016 MihaiH. All rights reserved.
//

#import "Session.h"

@implementation Session

-(id)initWithToken:(NSString*)token
{
    if (self = [super init])
    {
        _token = token;
    }
    return self;
}

-(BOOL)isValid
{
    return _token;
}

@end
