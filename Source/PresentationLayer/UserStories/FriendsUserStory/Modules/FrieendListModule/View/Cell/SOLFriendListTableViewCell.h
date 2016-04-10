//
//  SOLFriendListTableViewCell.h
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOLFriendListTableViewCellObject.h"

@interface SOLFriendListTableViewCell : UITableViewCell

- (BOOL)shouldUpdateCellWithObject:(SOLFriendListTableViewCellObject *)object;
+ (CGFloat)heightForObject:(SOLFriendListTableViewCellObject *)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;

@end
