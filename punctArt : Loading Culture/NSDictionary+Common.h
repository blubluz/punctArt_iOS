//
//  NSDictionary+Common.h
//  Mall
//
//  Created by Marcu Valentin on 16/07/15.
//  Copyright (c) 2015 mrott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Common)

- (id)safeObjectForKey:(id)key;
- (id)safeStringForKey:(id)key;

@end
