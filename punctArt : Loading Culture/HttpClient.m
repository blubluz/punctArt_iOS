//
//  RequestPaths.h
//  PunctArt
//
//  Created by MihaiH on 10/04/16.
//  Copyright © 2017 Honceriu Mihai. All rights reserved.
//

#import "HttpClient.h"


#define kBaseRequestURL    @"https://artloadingculture.herokuapp.com/"
#define kBaseUploadURL     @"https://artloadingculture.herokuapp.com/"


@interface HttpClient()

@property (nonatomic, assign) BOOL hasCookies;

@end

@implementation HttpClient

static HttpClient *sharedClient = nil;






+(instancetype)sharedHTTPClient
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kBaseRequestURL]];
        sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",nil];
        
    });
    
    NSOperationQueue *operationQueue = sharedClient.operationQueue;
    
    [sharedClient.operationQueue setMaxConcurrentOperationCount:5];
    
    [sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                
                break;
            case AFNetworkReachabilityStatusNotReachable:
                
            default:
                //                [RestClient noInternetConnectionAlert];
                [operationQueue setSuspended:NO];
                break;
        }
    }];
    
    sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
    
    if([SessionManager getSession].token)
    [sharedClient.requestSerializer setValue:[NSString stringWithFormat:@"%@ %@",@"Bearer",[SessionManager getSession].token] forHTTPHeaderField:@"Authorization"];
    
    return sharedClient;
}

-(void)performRequest:(id<RequestProtocol>)request
         WithResponse:(RequestResponse)block
{
    if ([request requestFormationError])
    {
        block(nil, [request requestFormationError]);
        return;
    }
    
    RequestMethodType methodType = RequestMethodTypePOST;
    
    if ([request respondsToSelector:@selector(requestMethodType)])
    {
        methodType = [request requestMethodType];
    }
    
    switch (methodType) {
        case RequestMethodTypeGET:
            [[HttpClient sharedHTTPClient] GET:[request requestPath]
                                          parameters:[request dictionaryForm] progress:nil
                                             success:[HttpClient successBlockWithResponseBlock:block
                                                                                           andClass:[request responseClass]]
                                             failure:[HttpClient failureBlockWithResponseBlock:block andClass:[request responseClass]]];
            break;
            
        case RequestMethodTypePOST:
            [[HttpClient sharedHTTPClient] POST:[request requestPath]
                                          parameters:[request dictionaryForm] progress:nil
                                             success:[HttpClient successBlockWithResponseBlock:block
                                                                                            andClass:[request responseClass]]
                                             failure:[HttpClient failureBlockWithResponseBlock:block andClass:[request responseClass]]];
            break;
            
        case RequestMethodTypePUT:
            [[HttpClient sharedHTTPClient] PUT:[request requestPath]
                                           parameters:[request dictionaryForm] 
                                              success:[HttpClient successBlockWithResponseBlock:block
                                                                                             andClass:[request responseClass]]
                                              failure:[HttpClient failureBlockWithResponseBlock:block andClass:[request responseClass]]];
            break;
            
        case RequestMethodTypeDELETE:
            [[HttpClient sharedHTTPClient] DELETE:[request requestPath]
                                             parameters:[request dictionaryForm]
                                                success:[HttpClient successBlockWithResponseBlock:block
                                                                                            andClass:[request responseClass]]
                                                failure:[HttpClient failureBlockWithResponseBlock:block andClass:[request responseClass]]];
            break;
            
       default:
            [[HttpClient sharedHTTPClient] POST:[request requestPath]
                                           parameters:[request dictionaryForm] progress:nil
                                              success:[HttpClient successBlockWithResponseBlock:block
                                                                                             andClass:[request responseClass]]
                                              failure:[HttpClient failureBlockWithResponseBlock:block andClass:[request responseClass]]];
            break;
    }
}

-(void)performMultipartRequest:(id<RequestProtocol, MultipartRequestProtocol>)request
                  WithResponse:(RequestResponse)block
{
    if ([request requestFormationError])
    {
        block(nil, [request requestFormationError]);
        return;
    }
    
    [[HttpClient sharedHTTPClient] POST:[request requestPath]
                                   parameters:[request dictionaryForm]
                    constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                        
                        
                        [formData appendPartWithFileData:[request data]
                                                    name:[request fileParameterName]
                                                fileName:[request fileName]
                                                mimeType:[request mimeType]];
                    } success:[HttpClient successBlockWithResponseBlock:block
                                                                     andClass:[request responseClass]]
                                      failure:[HttpClient failureBlockWithResponseBlock:block andClass:[request responseClass]]];
}

#pragma mark Helpers
+(void)cancelRequests
{
    [[[HttpClient sharedHTTPClient] operationQueue] cancelAllOperations];
}


+(void (^)(NSURLSessionDataTask *operation, id responseObject))successBlockWithResponseBlock:(RequestResponse)block
                                                                                      andClass:(Class)class
{
    return ^(NSURLSessionDataTask *operation, id responseObject)
    {
        if(responseObject)
        {
            
            id dict;
            BaseResponse *zuResponse;
            if([responseObject isKindOfClass:[NSArray class]]){
                dict = (NSArray *)responseObject;
                zuResponse = [[class alloc] initWithArray:dict];
            }
            else{
                dict = (NSDictionary *) responseObject;
                
                zuResponse = [[class alloc] initWithDictionary:dict];
            }
            
            if (dict)
            {
                    if(block)
                    {
                        block (zuResponse, nil);
                    }
                else
                {
                    if(block)
                    {
                        NSError* error = [[NSError alloc] initWithDomain:@"com.adonissoft" code:401 userInfo:nil];
                        
                        block(zuResponse, error);
                    }
                }
            }
        }
        else
        {
            if(block)
            {
                NSError* error = [[NSError alloc] init];
                
                block(nil, error);
            }
        }
        
    };
}
+ (NSDictionary *) JSONFromString:(NSString *) string {
    if (!string)
        return nil;
    
    NSError * err;
    NSData *data =[string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
    
    if (err)
        return nil;
    
    return json;
}
+(void (^)(NSURLSessionDataTask *operation, NSError *error))failureBlockWithResponseBlock:(RequestResponse)block andClass:(Class)class
{
    return ^(NSURLSessionDataTask *operation, NSError *error)
    {
        //        DLog(@"OPERATION RESPONSE: %@", operation.responseString);
        //        DLog(@"OPERATION ERROR: %lld, %@", (long long)[error code], [error localizedDescription]);
        NSString *responseString = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *responseObject = [self JSONFromString:responseString];
        
        if(responseObject)
        {
            id dict;
            BaseResponse *zuResponse;
            if([responseObject isKindOfClass:[NSArray class]]){
                dict = (NSArray *)responseObject;
                zuResponse = [[class alloc] initWithArray:dict];
            }
            else{
                dict = (NSDictionary *) responseObject;
                
                zuResponse = [[class alloc] initWithDictionary:dict];
            }
            
            if (dict)
            {
                if(block)
                {
                    block (zuResponse, nil);
                }
                else
                {
                    if(block)
                    {
                        NSError* error = [[NSError alloc] initWithDomain:@"com.adonissoft" code:401 userInfo:nil];
                        
                        block(zuResponse, error);
                    }
                }
            }
            else
                if(block)
                {
                    block(nil, error);
                }
        }
        else
            if(block)
            {
                block(nil, error);
            }
        
    };
}

+(NSString*)getImagePath:(NSString*)imagePath
{
    return [NSString stringWithFormat:@"%@/uploads/%@", kBaseUploadURL, imagePath];
}

+(NSString*)getFeedImagePath:(NSString*)imagePath
{
    return [NSString stringWithFormat:@"%@/img/%@", kBaseUploadURL, imagePath];
}

+(BOOL)isRequestOk:(NSUInteger)resultCode
{
    return resultCode == 1;
}
+(void) removeAllCookies
{
    sharedClient.hasCookies = NO;
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
}

#pragma mark - register & login
+(void) setSessionActive
{
    sharedClient.hasCookies = YES;
}


@end
