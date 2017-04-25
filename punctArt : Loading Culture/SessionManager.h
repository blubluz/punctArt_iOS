//
//  SessionManager.h
//  Liga Ultrass
//
//  Created by Mihai Honceriu on 21/11/16.
//  Copyright © 2016 MihaiH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Session.h"

@interface SessionManager : NSObject

+(Session*)getSession;
+(void)setSession:(Session*)token;
+(void)deleteSession;

@end
