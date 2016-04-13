//
//  SOLFriendListPresenter.m
//  Social
//
//  Created by Vitaliy Rusinov on 4/12/16.
//

#import "SOLFriendListPresenter.h"

@implementation SOLFriendListPresenter

#pragma mark - SOLFriendListInteractorOutput

- (void)didUpdateFriendList:(NSArray<SOLUserPlainObject *> *)friends {
    
    [_view updateViewWithFriendList:friends];
}

#pragma mark - SOLFriendListViewOutput

- (void)refreshData {
    
    [_interactor updateFriendList];
}

- (void)viewDidLoad {
    
    NSArray <SOLUserPlainObject *> *plainObjs = [_interactor obtainFriendList];
    [_view setupViewWithFriendList:plainObjs];
    [_interactor updateFriendList];
}

- (void)didSelectCellWithFriend:(SOLUserPlainObject *)friend {
    
//    _router
}

@end
