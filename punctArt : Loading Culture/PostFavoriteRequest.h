//
//  PostFavoriteRequest.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 27/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostFavoriteRequest : NSObject <RequestProtocol>

@property(nonatomic) BOOL isFavourite;
@property(strong, nonatomic) NSNumber *playId;
-(id)initWithPlayId:(NSNumber *)playId andIsFav:(BOOL)isFavourite;

@end
