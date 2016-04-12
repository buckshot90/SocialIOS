//
//  SOLFriendListPresenter.h
//  Social
//
//  Created by Vitaliy Rusinov on 4/12/16.
//

#import <Foundation/Foundation.h>
#import "SOLFriendListInteractorInput.h"
#import "SOLFriendListInteractorOutput.h"
#import "SOLFriendListViewInput.h"
#import "SOLFriendListViewOutput.h"
#import "SOLFriendListRouterInput.h"

@interface SOLFriendListPresenter : NSObject <SOLFriendListInteractorOutput, SOLFriendListViewOutput>

@property (weak, nonatomic) id<SOLFriendListViewInput>view;
@property (strong, nonatomic) id<SOLFriendListInteractorInput>interactor;
@property (strong, nonatomic) id<SOLFriendListRouterInput>router;

@end
