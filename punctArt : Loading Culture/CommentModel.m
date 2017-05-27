//
//  CommentModel.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 27/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
-(id)initWithDictionary:(NSDictionary *)dict{
    self.commentText = [dict safeObjectForKey:@"comment_text"];
    NSString *dateString = [dict safeObjectForKey:@"created"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    self.createdAt = [dateFormatter dateFromString:dateString];
    self.author = [[LoggedUser alloc] initWithDictionary:[dict safeObjectForKey:@"user"]];
    return self;
}
@end
