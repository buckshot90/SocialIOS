//
//  SOLFriendListInteractor.m
//  Social
//
//  Created by Vitaliy Rusinov on 4/12/16.
//

#import "SOLFriendListInteractor.h"

@implementation SOLFriendListInteractor

#pragma mark - SOLFriendListInteractorInput

- (void)updateFriendList {
    
    [_service updateUsersWithPredicate:nil completionBlock:^(NSArray<SOLUserPlainObject *> *list, NSError *error) {
       
        [_output didUpdateFriendList:list];
    }];
}

- (NSArray<SOLUserPlainObject *> *)obtainFriendList {
    
    return [_service obtainUsersWithPredicate:nil];
}

@end
