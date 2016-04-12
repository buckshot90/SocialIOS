//
//  SOLFriendListInteractorInput.h
//  Social
//
//  Created by Vitaliy Rusinov on 4/12/16.
//

#import <Foundation/Foundation.h>
@class SOLUserPlainObject;

@protocol SOLFriendListInteractorInput <NSObject>

- (void)updateFriendList;
- (NSArray<SOLUserPlainObject *> *)obtainFriendList;

@end
