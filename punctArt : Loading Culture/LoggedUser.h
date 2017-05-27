//
//  User.h
//  Liga Ultrass
//
//  Created by Mihai Honceriu on 18/11/16.
//  Copyright © 2016 MihaiH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoggedUser : NSObject <NSCoding>


@property(strong, nonatomic) NSString *photoUrl;
@property(strong, nonatomic) NSString *userId;
@property(strong, nonatomic) NSString *username;
@property(strong, nonatomic) NSString *firstName;
@property(strong, nonatomic) NSString *lastName;
@property(strong, nonatomic) NSString *email;

-(id)initWithDictionary:(NSDictionary *)dictionary;

-(void)saveUser;
+(LoggedUser*)loadUser;
+(void)deleteUser;


@end
