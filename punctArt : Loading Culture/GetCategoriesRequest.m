//
//  GetCategoriesRequest.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 26/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "GetCategoriesRequest.h"

@implementation GetCategoriesRequest 
-(NSString *)requestPath{
    return kCategories;
}
-(RequestMethodType)requestMethodType{
    return RequestMethodTypeGET;
}
-(NSError *)requestFormationError{
    return nil;
}
-(Class)responseClass{
    return [GetCategoriesResponse class];
}
-(NSDictionary *)dictionaryForm{
    return nil;
}
@end
@implementation GetCategoriesResponse

-(id)initWithDictionary:(NSDictionary *)dict{
    if(self = [super initWithDictionary:dict]){
        NSMutableArray *categories = [[NSMutableArray alloc] init];
        NSArray *result = [dict safeObjectForKey:@"results"];
        CategoryModel *allCategory = [[CategoryModel alloc] init];
        allCategory.categoryId = @(0);
        allCategory.categoryName = @"Toate";
        [categories addObject:allCategory];
        for(NSDictionary *dict in result ){
            CategoryModel *category = [[CategoryModel alloc] initWithDictionary:dict];
            [categories addObject:category];
        }
        self.categories = categories;
    }
    return self;
}

@end
