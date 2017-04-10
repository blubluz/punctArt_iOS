//
//  NSArray+Common.m
//  Prispa2
//
//  Created by Florian Parvan on 03/12/15.
//  Copyright © 2015 Toma Andrei. All rights reserved.
//

#import "NSArray+Common.h"

@implementation NSArray (Common)

+(NSArray*)arrayWithObjectClass:(Class)className
                      andSource:(NSArray*)sourceArray
{
    NSMutableArray *arrReturnArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in sourceArray)
    {
        [arrReturnArray addObject:[[className alloc]initWithDictionary:dict]];
    }
    return [NSArray arrayWithArray:arrReturnArray];
}

@end
