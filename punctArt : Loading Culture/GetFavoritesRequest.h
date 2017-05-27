//
//  GetFavoritesRequest.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 27/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayRepresentationModel.h"
#import "PlayModel.h"
@interface GetFavoritesRequest : NSObject <RequestProtocol>



@end
@interface GetFavoritesResponse : BaseResponse
@property(strong, nonatomic) NSArray<PlayModel *> *plays;

@end
