//
//  ViewController.h
//  CodingChallange
//
//  Created by Pro on 04/03/2016.
//  Copyright © 2016 Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

{

}

@property (nonatomic, weak)IBOutlet UITableView *tableView;

@end

