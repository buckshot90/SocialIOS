//
//  POOFriendService.h
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 12.04.16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "POOVKUserModel.h"

typedef void (^FriendCompletitionBlock)(NSArray<POOVKUserModel *> *response, NSError *error);

@protocol POOFriendService <NSObject>

- (void)getFriendsInfoWithId:(NSString *)userId order:(NSString *)order block:(FriendCompletitionBlock)block;

- (void)GetFollowersWithId:(NSString *)id offset:(NSInteger)offset count:(NSInteger)count block:(FriendCompletitionBlock)block;

- (void)getSuggestionsWithFilter:(NSString *)filter count:(NSInteger)count offset:(NSInteger)offset block:(FriendCompletitionBlock)block;

- (void)getUserInfoWithIds:(NSArray *)friends block:(FriendCompletitionBlock)block;

- (void)getInvitesWith:(BOOL)extended needMutual:(BOOL)needmMtual out:(BOOL)out block:(FriendCompletitionBlock)block;

@end
