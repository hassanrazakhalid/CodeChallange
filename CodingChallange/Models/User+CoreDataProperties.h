//
//  User+CoreDataProperties.h
//  CodingChallange
//
//  Created by Pro on 05/03/2016.
//  Copyright © 2016 Pro. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *userName;
@property (nullable, nonatomic, retain) NSSet<Tweet *> *tweets;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addTweetsObject:(Tweet *)value;
- (void)removeTweetsObject:(Tweet *)value;
- (void)addTweets:(NSSet<Tweet *> *)values;
- (void)removeTweets:(NSSet<Tweet *> *)values;

@end

NS_ASSUME_NONNULL_END
