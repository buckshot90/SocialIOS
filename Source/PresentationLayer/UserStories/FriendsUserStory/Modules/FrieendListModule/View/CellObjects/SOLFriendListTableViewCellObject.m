//
//  SOLFriendListTableViewCellObject.m
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//

#import "SOLFriendListTableViewCellObject.h"
#import "SOLUserPlainObject.h"

@implementation SOLFriendListTableViewCellObject

+ (instancetype)objectWithUser:(SOLUserPlainObject *)user {
    
    return [[SOLFriendListTableViewCellObject alloc] initWithUser:user];
}

- (instancetype)initWithUser:(SOLUserPlainObject *)user {
    
    self = [super init];
    if (self) {
        
        _userName = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
        _userPhoto = [NSURL URLWithString:user.photoLow];
        _userOnline = user.online;
        _userOnlineMobile = user.onlineMobile;
    }
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"name: %@, online: %i, onlineMobile: %i", _userName, _userOnline, _userOnlineMobile];
}

@end
