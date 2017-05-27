//
//  GetCategoriesRequest.h
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 26/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryModel.h"
@interface GetCategoriesRequest : NSObject <RequestProtocol>

@end

@interface GetCategoriesResponse : BaseResponse
@property(strong, nonatomic) NSArray<CategoryModel *> *categories;
@end
