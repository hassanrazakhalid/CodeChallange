//
//  TwitterViewController.m
//  CodingChallange
//
//  Created by Pro on 04/03/2016.
//  Copyright © 2016 Pro. All rights reserved.
//

#import "TwitterViewController.h"

@interface TwitterViewController () <UITableViewDataSource, UITableViewDelegate>

{

}

@end

@implementation TwitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetsArray = [NSMutableArray array];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{

    return self.tweetsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{

    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    [cell reloadData:self.tweetsArray[indexPath.row]];
    return cell;
    
}


@end
