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
    self.firstName = [dictionary safeObjectForKey:@"first_name"];
    self.userId = [dictionary safeObjectForKey:@"id"];
    self.lastName = [dictionary safeObjectForKey:@"last_name"];
    self.photoUrl = [NSString stringWithFormat:@"%@%@",[dictionary safeObjectForKey:@"profile"],@"?type=large"] ;
    self.username = [dictionary safeObjectForKey:@"username"];
    return self;
}

#pragma mark - Public Methods
-(void)saveUser
{
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if(!self){
        [defaults setNilValueForKey:@"LoggedUser"];
        return;
    }
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
#define kFirstName @"FirstNameKey"
#define kLastName @"LastNameKey"
#define kUserId @"UserIdKey"
#define kPhotoUrl @"PhotoUrlKey"
#define kUsername @"UsernameKey"

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.firstName forKey:kFirstName];
    [aCoder encodeObject:self.lastName forKey:kLastName];
    [aCoder encodeObject:self.userId forKey:kUserId];
    [aCoder encodeObject:self.photoUrl forKey:kPhotoUrl];
    [aCoder encodeObject:self.username forKey:kUsername];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.firstName = [aDecoder decodeObjectForKey:kFirstName];
    self.lastName = [aDecoder decodeObjectForKey:kLastName];
    self.userId = [aDecoder decodeObjectForKey:kUserId];
    self.photoUrl = [aDecoder decodeObjectForKey:kPhotoUrl];
    self.username = [aDecoder decodeObjectForKey:kUsername];
    return self;
}
@end
