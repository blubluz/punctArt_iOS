//
//  RequestPaths.h
//  PunctArt
//
//  Created by MihaiH on 10/04/16.
//  Copyright © 2017 Honceriu Mihai. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "RequestPaths.h"

typedef enum
{
    RequestMethodTypeUNDEFINED,
    RequestMethodTypeGET,
    RequestMethodTypePOST,
    RequestMethodTypeDELETE,
    RequestMethodTypePUT,
}RequestMethodType;

@protocol RequestProtocol <NSObject>

-(Class)responseClass;
-(NSString*)requestPath;
-(NSDictionary*)dictionaryForm;
-(NSError*)requestFormationError;

@optional
-(RequestMethodType)requestMethodType;

@end


