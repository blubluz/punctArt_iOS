//
//  RequestPaths.h
//  PunctArt
//
//  Created by MihaiH on 10/04/16.
//  Copyright © 2017 Honceriu Mihai. All rights reserved.
//

#import "AFNetworking/AFNetworking.h"
#import "RequestProtocol.h"
#import "MultipartRequestProtocol.h"
#import "BaseResponse.h"

typedef void (^RequestResponse)(BaseResponse *response, NSError* error);

@interface HttpClient : AFHTTPSessionManager

+(id)sharedHTTPClient;

-(void)performRequest:(id<RequestProtocol>)request
         WithResponse:(RequestResponse)block;

-(void)performMultipartRequest:(id<RequestProtocol, MultipartRequestProtocol>)request
                  WithResponse:(RequestResponse)block;

+(void) removeAllCookies;

+(void) setSessionActive;
@end
