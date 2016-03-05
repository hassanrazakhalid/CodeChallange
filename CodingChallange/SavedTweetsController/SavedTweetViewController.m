//
//  SavedTweetViewController.m
//  CodingChallange
//
//  Created by Pro on 05/03/2016.
//  Copyright © 2016 Pro. All rights reserved.
//

#import "SavedTweetViewController.h"

@interface SavedTweetViewController ()

@end

@implementation SavedTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tweetsArray addObjectsFromArray:[SharedData sharedInstance].currentUser.tweets.allObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// delete tweets locally annd frm CoreData
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;{

    [[SharedData sharedInstance].currentUser removeTweetsObject:self.tweetsArray[indexPath.row]];
    
    [self.tweetsArray removeObject:self.tweetsArray[indexPath.row]];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    [(AppDelegate *)[[UIApplication sharedApplication]delegate] saveContext];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
