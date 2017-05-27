//
//  GetFavoritesRequest.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 27/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "GetFavoritesRequest.h"

@implementation GetFavoritesRequest
-(NSString *)requestPath{
    return kFavourites;
}
-(RequestMethodType)requestMethodType{
    return RequestMethodTypeGET;
}
-(NSError *)requestFormationError{
    return nil;
}
-(Class)responseClass{
    return [GetFavoritesResponse class];
}
-(NSDictionary *)dictionaryForm{
    return nil;
}

@end
@implementation GetFavoritesResponse

-(id)initWithDictionary:(NSDictionary *)dict{
    if(self = [super initWithDictionary:dict]){
        NSArray *results = [dict safeObjectForKey:@"results"];
        NSMutableArray<PlayModel *> *plays = [[NSMutableArray alloc] init];
        for(NSDictionary *dict in results){
            PlayModel *play = [[PlayModel alloc] initWithDictionary:dict];
            [plays addObject:play];
        }
        self.plays = plays;
    }
    return self;
}

@end
