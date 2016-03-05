//
//  User.h
//  CodingChallange
//
//  Created by Pro on 05/03/2016.
//  Copyright © 2016 Pro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <Accounts/Accounts.h>

@class Tweet;

NS_ASSUME_NONNULL_BEGIN

@interface User : NSManagedObject

{

}

@property (nonatomic, retain)ACAccount *twitterAccount;
+ (User *)insertUser:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END

#import "User+CoreDataProperties.h"
