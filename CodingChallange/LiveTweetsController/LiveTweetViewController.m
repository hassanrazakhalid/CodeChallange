//
//  LiveTweetViewController.m
//  CodingChallange
//
//  Created by Pro on 05/03/2016.
//  Copyright © 2016 Pro. All rights reserved.
//

#import "LiveTweetViewController.h"

@interface LiveTweetViewController ()<UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating>

{

}
@property (nonatomic, retain)UISearchController *searchController;

@end

@implementation LiveTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSearchViewController];
    [self checkForRightBar];
}

// adding native search controller
- (void)addSearchViewController{

    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    [self.searchController setSearchResultsUpdater:self];
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchBar.delegate = self;
    self.definesPresentationContext = YES;
}

- (void)checkForRightBar{

    if(self.tableView.indexPathsForSelectedRows.count)
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
    else
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// When save tweets clicked
- (IBAction)saveTweets:(id)sender{
    
    NSArray *selectedIndexPaths = self.tableView.indexPathsForSelectedRows;
    for (NSIndexPath *indexPath in selectedIndexPaths) {
        
        [[SharedData sharedInstance].currentUser addTweetsObject:self.tweetsArray[indexPath.row]];
    }
    
    [(AppDelegate *)[[UIApplication sharedApplication]delegate] saveContext];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Saved" message:@"Tweets saved successfully" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)reloadTweetsWithString:(NSString *)searchText{

    [[SharedData sharedInstance] getTweetsInfo:searchText callback:^(NSArray *parsedList) {
        
        if(parsedList)
        {
            [self.tweetsArray removeAllObjects];
            [self.tweetsArray addObjectsFromArray:parsedList];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - UITableView Deleagete

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{

    [self checkForRightBar];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self checkForRightBar];
}

#pragma mark - UISearchController Delegates

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;{

    [self.searchController dismissViewControllerAnimated:YES completion:nil];
    [self reloadTweetsWithString:searchBar.text];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController;{

}

@end
