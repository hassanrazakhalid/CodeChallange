//
//  TwitterViewController.h
//  CodingChallange
//
//  Created by Pro on 04/03/2016.
//  Copyright © 2016 Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetCell.h"
#import "User.h"

@interface TwitterViewController : UIViewController

{

}

@property (nonatomic, retain)NSMutableArray *tweetsArray;
@property (nonatomic, weak)IBOutlet UITableView *tableView;


@end
