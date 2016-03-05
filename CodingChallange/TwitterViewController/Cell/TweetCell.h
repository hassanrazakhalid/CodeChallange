//
//  TweetCell.h
//  CodingChallange
//
//  Created by Pro on 05/03/2016.
//  Copyright © 2016 Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tweet;

@interface TweetCell : UITableViewCell

{

}

@property (nonatomic, weak)IBOutlet UIImageView *userImage;
@property (nonatomic, weak)IBOutlet UILabel *name;
@property (nonatomic, weak)IBOutlet UILabel *createdDate;
@property (nonatomic, weak)IBOutlet UILabel *location;

- (void)reloadData:(Tweet *)tweet;

@end
