//
//  SOLFriendListTableViewController.h
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOLFriendListDataDisplayManager.h"

@interface SOLFriendListTableViewController : UITableViewController

@property (strong, nonatomic) SOLFriendListDataDisplayManager *dataDisplayManager;

@end
