//
//  SOLFriendListInteractor.h
//  Social
//
//  Created by Vitaliy Rusinov on 4/12/16.
//

#import <Foundation/Foundation.h>
#import "SOLFriendListInteractorOutput.h"
#import "SOLFriendListInteractorInput.h"
#import "SOLUserService.h"

@interface SOLFriendListInteractor : NSObject <SOLFriendListInteractorInput>

@property (weak, nonatomic) id<SOLFriendListInteractorOutput>output;
@property (strong, nonatomic) id<SOLUserService>service;

@end
