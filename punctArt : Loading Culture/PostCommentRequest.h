//
//  PostCommentRequest.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 27/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SessionManager.h"
@interface PostCommentRequest : NSObject <RequestProtocol>
@property(strong, nonatomic) NSString *commentText;
@property(strong, nonatomic) NSNumber *playId;
-(id)initWithCommentText:(NSString *)commentText andPlayId:(NSNumber *)playId;
@end
