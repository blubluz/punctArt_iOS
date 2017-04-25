//
//  Session.h
//  Liga Ultrass
//
//  Created by Mihai Honceriu on 21/11/16.
//  Copyright © 2016 MihaiH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Session : NSObject
@property (nonatomic, strong) NSString *token;

-(id)initWithToken:(NSString*)token;

-(BOOL)isValid;

@end
