//
//  NSArray+Common.h
//  Prispa2
//
//  Created by Florian Parvan on 03/12/15.
//  Copyright © 2015 Toma Andrei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ObjectInializer <NSObject>

-(id)initWithDictionary:(NSDictionary*)dict;

@end

@interface NSArray (Common)

+(NSArray*)arrayWithObjectClass:(Class)className
                      andSource:(NSArray*)sourceArray;

@end
