//
//  SessionManager.m
//  Liga Ultrass
//
//  Created by Mihai Honceriu on 21/11/16.
//  Copyright © 2016 MihaiH. All rights reserved.
//

#import "SessionManager.h"

@implementation SessionManager
static Session *session;

+(Session*)getSession
{
    if (!session)
    {
        NSString *sessionToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"Token"];
        //        NSString *sessionToken = [SSKeychain passwordForService:@"Token" account:@"Token"];
        //        NSString *userId = [SSKeychain passwordForService:@"UserId" account:@"UserId"];
        
        session = [[Session alloc] initWithToken:sessionToken];
    }
    
    return session;
}

+(void)setSession:(Session*)newSession
{
    session = newSession;
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    [standardUserDefaults setObject:newSession.token forKey:@"Token"];
    
    //    [SSKeychain setPassword:newSession.token forService:@"Token" account:@"Token"];
    //    [SSKeychain setPassword:newSession.userId forService:@"UserId" account:@"UserId"];
}

+(void)deleteSession
{
    session = nil;
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    [standardUserDefaults setObject:nil forKey:@"Token"];
}

@end
