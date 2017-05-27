//
//  CommentModel.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 27/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject <ObjectInializer>
@property(strong, nonatomic) NSString *commentText;
@property(strong, nonatomic) NSDate *createdAt;
@property(strong, nonatomic) NSNumber *playId;
@property(strong, nonatomic) LoggedUser *author;
@end
