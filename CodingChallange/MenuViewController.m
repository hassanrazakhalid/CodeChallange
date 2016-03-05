//
//  ViewController.m
//  CodingChallange
//
//  Created by Pro on 04/03/2016.
//  Copyright © 2016 Pro. All rights reserved.
//

#import "MenuViewController.h"
#import "User.h"

@interface MenuViewController ()

{

}

@property (nonatomic, retain)NSArray *menuDataSource;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuDataSource = @[@"View Latest Tweets",@"Saved Tweets"];
    [[SharedData sharedInstance]loginTwiiterUser];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{

    return self.menuDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    cell.textLabel.text = self.menuDataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{

    // Check if twitter account is logged in otherwise show error
    if([SharedData sharedInstance].currentUser.twitterAccount)
    {
        switch (indexPath.row) {
            case MenuRowTweets:
                [self performSegueWithIdentifier:@"toTwitterViewController" sender:nil];
                break;
            case MenuRowOldTweets:
                
                [self performSegueWithIdentifier:@"toSavedTwitterViewController" sender:nil];
                break;
                
            default:
                break;
        }
    }
    else
    {
        [self showError:@"Twitter account not logged in"];
    }
}

#pragma mark -

- (void)showError:(NSString *)error{

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:error
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];

}

@end
