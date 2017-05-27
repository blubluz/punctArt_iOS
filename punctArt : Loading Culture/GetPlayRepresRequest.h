//
//  GetPlayRepresRequest.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 10/04/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayRepresentationModel.h"
@interface GetPlayRepresRequest : NSObject <RequestProtocol>
@property(strong, nonatomic) NSString *orderType; //date/rating
@property(strong, nonatomic) NSNumber *categoryId;
@property(strong, nonatomic) NSNumber *theaterId;
@property(strong, nonatomic) NSString *cityName;
@property(strong, nonatomic) NSString *searchQuery;

@end

@interface GetPlayRepresResponse : BaseResponse
@property(strong, nonatomic) NSArray<PlayRepresentationModel *> *playReps;
@end
