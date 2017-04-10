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
    return nil;
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
