//
//  User.m
//  Liga Ultrass
//
//  Created by Mihai Honceriu on 18/11/16.
//  Copyright © 2016 MihaiH. All rights reserved.
//

#import "LoggedUser.h"

@implementation LoggedUser
-(id)initWithDictionary:(NSDictionary *)dictionary{
    
    return self;
}

#pragma mark - Public Methods
-(void)saveUser
{
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:@"LoggedUser"];
    [defaults synchronize];
}

+(LoggedUser*)loadUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:@"LoggedUser"];
    LoggedUser *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

+(void)deleteUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"LoggedUser"];
    [defaults synchronize];
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
   
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
        return self;
}
@end
