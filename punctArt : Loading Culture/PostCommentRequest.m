//
//  PostCommentRequest.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 27/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "PostCommentRequest.h"

@implementation PostCommentRequest
-(id)initWithCommentText:(NSString *)commentText andPlayId:(NSNumber *)playId{
    self.commentText = commentText;
    self.playId = playId;
    return self;
}
-(NSString *)requestPath{
    return kPostComment;
}
-(RequestMethodType)requestMethodType{
    return RequestMethodTypePOST;
}
-(NSError *)requestFormationError{
    return nil;
}
-(Class)responseClass{
    return [BaseResponse class];
}
-(NSDictionary *)dictionaryForm{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.commentText,@"comment_text",self.playId.stringValue,@"play", nil];
}
@end
