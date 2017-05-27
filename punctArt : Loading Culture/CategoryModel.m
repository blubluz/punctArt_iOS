//
//  CategoryModel.m
//  punctArt : Loading Culture
//
//  Created by Mihai Honceriu on 26/05/2017.
//  Copyright © 2017 Mihai Honceriu. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel
-(id)initWithDictionary:(NSDictionary *)dict{
    self.categoryName = [dict safeObjectForKey:@"name"];
    self.categoryId = [dict safeObjectForKey:@"id"];
    return self;
}
@end
