//
//  TweetCell.m
//  CodingChallange
//
//  Created by Pro on 05/03/2016.
//  Copyright © 2016 Pro. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"

@interface TweetCell ()

{
    
}

@property (nonatomic, weak)Tweet *tweet;

@end

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)reloadData:(Tweet *)tweet;{

    self.tweet = tweet;
    
    self.name.text = tweet.name;
    self.createdDate.text = tweet.createdDate;
    self.location.text = tweet.location;

    [tweet getImage:^(id obj) {
       
        if(obj == self.tweet)
        {
            UIImage *image = self.tweet.image;
            if(image)
            {
                [self.userImage setImage:image];
            }
            else
            {
                [self.userImage setImage:nil];
            }
        }
    }];
    
}

@end
