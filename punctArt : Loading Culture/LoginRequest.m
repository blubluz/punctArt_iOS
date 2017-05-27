//
//  LoginRequest.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 26/04/17.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest
-(id)initWithToken:(NSString *)token andPlatform:(LoginPlatform)platform{
    self.token = token;
    self.loginPlatform = platform;
    return self;
}
-(NSString *)requestPath{
    return kLogin;
}
-(RequestMethodType)requestMethodType{
    return RequestMethodTypePOST;
}
-(NSError *)requestFormationError{
    return nil;
}
-(NSDictionary *)dictionaryForm{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    if(self.token)
        jsonDict[@"token"] = self.token;
    if(self.loginPlatform == Facebook)
        jsonDict[@"backend"] = @"facebook";
    else
        jsonDict[@"backend"] = @"google";
    jsonDict[@"grant_type"]=@"convert_token";
    jsonDict[@"client_id"] = kClientId;
    jsonDict[@"client_secret"] = kClientSecret;
    return jsonDict;
}
-(Class)responseClass{
    return [LoginResponse class];
}
@end

@implementation LoginResponse

-(id)initWithDictionary:(NSDictionary *)dict{
    if(self = [super initWithDictionary:dict]){
        NSString *token = [dict safeObjectForKey:@"access_token"];
        Session *session = [[Session alloc] initWithToken:token];
        [SessionManager setSession:session];
        LoggedUser *loggedUser = [[LoggedUser alloc] initWithDictionary:[dict safeObjectForKey:@"user"]];
        [loggedUser saveUser];
    }
    return self;
}

@end
