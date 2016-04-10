//
//  SOLFriendListTableViewCellObject.h
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//

#import <Foundation/Foundation.h>
@class SOLUserPlainObject;

@interface SOLFriendListTableViewCellObject : NSObject

@property (copy, nonatomic, readonly) NSString *userName;
@property (copy, nonatomic, readonly) NSURL *userPhoto;
@property (assign, nonatomic, readonly) BOOL userOnline;
@property (assign, nonatomic, readonly) BOOL userOnlineMobile;

+ (instancetype)objectWithUser:(SOLUserPlainObject *)user;

@end
