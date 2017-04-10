//
//  NSDictionary+Common.m
//  Mall
//
//  Created by Marcu Valentin on 16/07/15.
//  Copyright (c) 2015 mrott. All rights reserved.
//

#import "NSDictionary+Common.h"

@implementation NSDictionary (Common)



- (id)safeObjectForKey:(id)key
{
    id value = [self valueForKey:key];
    
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

-(id)safeStringForKey:(id)key
{
    id value = [self valueForKey:key];
    
    if (value == [NSNull null]) {
        return nil;
    }
    NSString *retString = [NSString stringWithFormat:@"%@",value];
    retString = [retString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return retString;
}


@end
