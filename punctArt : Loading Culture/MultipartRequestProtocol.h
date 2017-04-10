//
//  RequestPaths.h
//  PunctArt
//
//  Created by MihaiH on 10/04/16.
//  Copyright © 2017 Honceriu Mihai. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol MultipartRequestProtocol <NSObject>

-(NSString*)mimeType;
-(NSData*)data;
-(NSString*)fileName;
-(NSString*)fileParameterName;

@end
