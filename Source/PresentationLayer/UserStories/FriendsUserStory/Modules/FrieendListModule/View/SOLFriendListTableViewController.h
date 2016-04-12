//
//  SOLFriendListTableViewController.h
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//

#import <UIKit/UIKit.h>
#import "SOLFriendListDataDisplayManager.h"
#import "SOLFriendListViewInput.h"
#import "SOLFriendListViewOutput.h"

@interface SOLFriendListTableViewController : UITableViewController <SOLFriendListViewInput>

@property (strong, nonatomic) id<SOLFriendListViewOutput> output;
@property (strong, nonatomic) SOLFriendListDataDisplayManager *dataDisplayManager;

@end
