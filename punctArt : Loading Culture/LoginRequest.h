//
//  LoginRequest.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 26/04/17.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginRequest : NSObject <RequestProtocol>

@property(strong, nonatomic) NSString *token;
@property(nonatomic) LoginPlatform loginPlatform;
-(id)initWithToken:(NSString *)token andPlatform:(LoginPlatform)platform;
@end

@interface LoginResponse : BaseResponse

@property(strong, nonatomic) LoggedUser *loggedUser;
@property(strong, nonatomic) NSString *sessionToken;

@end
