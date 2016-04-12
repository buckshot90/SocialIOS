//
//  SOLFriendListViewInput.h
//  Social
//
//  Created by Vitaliy Rusinov on 4/12/16.
//

#import <Foundation/Foundation.h>
@class SOLUserPlainObject;

@protocol SOLFriendListViewInput <NSObject>

- (void)setupViewWithFriendList:(NSArray<SOLUserPlainObject *> *)friends;
- (void)updateViewWithFriendList:(NSArray<SOLUserPlainObject *> *)friends;

@end
