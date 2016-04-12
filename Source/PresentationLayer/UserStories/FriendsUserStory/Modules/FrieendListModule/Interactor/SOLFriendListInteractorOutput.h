//
//  SOLFriendListInteractorOutput.h
//  Social
//
//  Created by Vitaliy Rusinov on 4/12/16.
//

#import <Foundation/Foundation.h>
#import "SOLUserPlainObject.h"

@protocol SOLFriendListInteractorOutput <NSObject>

- (void)didUpdateFriendList:(NSArray<SOLUserPlainObject *> *)friends;

@end
