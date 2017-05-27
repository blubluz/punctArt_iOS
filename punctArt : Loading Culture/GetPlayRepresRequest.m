//
//  GetPlayRepresRequest.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 10/04/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "GetPlayRepresRequest.h"

@implementation GetPlayRepresRequest
-(NSString *)requestPath{
    return kGetPlayRepres;
}
-(NSError *)requestFormationError{
    return nil;
}
-(RequestMethodType)requestMethodType{
    return RequestMethodTypeGET;
}
-(NSDictionary *)dictionaryForm{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    if(self.orderType)
        jsonDict[@"ordering"] = self.orderType;
    else
        jsonDict[@"ordering"] = @"date";
    if(self.categoryId)
        jsonDict[@"play__category"] = self.categoryId.stringValue;
    if(self.searchQuery)
        jsonDict[@"search"] = self.searchQuery;
    return jsonDict;
}
-(Class)responseClass{
    return [GetPlayRepresResponse class];
}
@end

@implementation GetPlayRepresResponse

-(id)initWithDictionary:(NSDictionary *)dict{
    if(self = [super initWithDictionary:dict]){
        self.playReps = [NSArray arrayWithObjectClass:[PlayRepresentationModel class] andSource:[dict safeObjectForKey:@"results"]];
    }
    return self;
}

@end
