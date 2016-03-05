//
//  User.m
//  CodingChallange
//
//  Created by Pro on 05/03/2016.
//  Copyright © 2016 Pro. All rights reserved.
//

#import "User.h"
#import "Tweet.h"

@implementation User

@synthesize twitterAccount;

// insert the user and also check if it already exists
+ (User *)insertUser:(NSDictionary *)info{
    
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication]delegate] managedObjectContext];
    User *user = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.userName == %@",info[_kUserName]];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects.count) {
    
        user = fetchedObjects[0];
        
    }
    else
    {
        user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    }
    
    [user reloadData:info];
    return user;
}

- (void)reloadData:(NSDictionary *)info{

    if(info[@"name"])
        self.name = info[@"name"];

    if(info[_kUserName])
        self.userName = info[_kUserName];

}

@end
