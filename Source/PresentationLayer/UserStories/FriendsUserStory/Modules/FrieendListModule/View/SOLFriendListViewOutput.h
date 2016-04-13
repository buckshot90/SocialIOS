//
//  SOLFriendListViewOutput.h
//  Social
//
//  Created by Vitaliy Rusinov on 4/12/16.
//

#import <Foundation/Foundation.h>
#import "SOLUserPlainObject.h"

@protocol SOLFriendListViewOutput <NSObject>

- (void)viewDidLoad;
- (void)refreshData;
- (void)didSelectCellWithFriend:(SOLUserPlainObject *)friend;

@end
