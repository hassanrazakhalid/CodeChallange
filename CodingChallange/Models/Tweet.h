//
//  Tweet.h
//  CodingChallange
//
//  Created by Pro on 05/03/2016.
//  Copyright © 2016 Pro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tweet : NSManagedObject

{

}
@property (nonatomic, assign)ImageStatus imageStatus;

// Insert code here to declare functionality of your managed object subclass
+ (Tweet *)insertTweet:(NSDictionary *)info;
- (void)reloadData:(NSDictionary *)info;

- (void)getImage:(ImageCallback)callBack;
@end

NS_ASSUME_NONNULL_END

#import "Tweet+CoreDataProperties.h"
