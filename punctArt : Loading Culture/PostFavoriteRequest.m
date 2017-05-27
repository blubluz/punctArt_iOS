//
//  PostFavoriteRequest.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 27/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "PostFavoriteRequest.h"

@implementation PostFavoriteRequest
-(id)initWithPlayId:(NSNumber *)playId andIsFav:(BOOL)isFavourite{
    self.playId = playId;
    self.isFavourite = isFavourite;
    return self;
}
-(NSString *)requestPath{
    return kFavourite;
}
-(RequestMethodType)requestMethodType{
    return RequestMethodTypePOST;
}
-(NSError *)requestFormationError{
    return nil;
}
-(NSDictionary *)dictionaryForm{
    return @{@"is_favorite":self.isFavourite?@"true":@"false",@"play":self.playId.stringValue};
}
-(Class)responseClass{
    return [BaseResponse class];
}
@end
