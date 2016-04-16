//
//  POOFriendServiceImplementation.m
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 12.04.16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "POOFriendServiceImplementation.h"
#import "POOVKUserModel.h"
#import "VKSdk.h"

@implementation POOFriendServiceImplementation

- (void)getFriendsInfoWithId:(NSString *)userId order:(NSString *)order block:(FriendCompletitionBlock)block {
    
    BOOL validParameterId = userId.length > 0 ? TRUE : FALSE;
    BOOL validParameteOrder = order.length > 0 ? TRUE : FALSE;
    if (validParameterId && validParameteOrder) {
        
        NSMutableArray<POOVKUserModel *> *friends = [NSMutableArray array];
        VKRequest *request = [VKRequest requestWithMethod:@"friends.get"
                                            andParameters:@{VK_API_USER_ID : userId,
                                                            VK_API_ORDER: order,
                                                            VK_API_FIELDS : @[VK_API_ONLINE,
                                                                              VK_API_PHOTO]}];
        
        [request executeWithResultBlock:^(VKResponse *response) {
            if ([response.json isKindOfClass:[NSDictionary class]]) {
                
                for (NSDictionary *friend in [response.json objectForKey:@"items"]) {
                    [friends addObject:[[POOVKUserModel alloc]initWithDictionary:friend]];
                }
            }
            
            if (friends.count > 0) {
                block([friends copy], nil);
            }
            
        } errorBlock:^(NSError *error) {
            block(nil, error);
        }];
    }
}

- (void)GetFollowersWithId:(NSString *)id offset:(NSInteger)offset count:(NSInteger)count block:(FriendCompletitionBlock)block {
    
    BOOL validParameters = id.length > 0 ? TRUE : FALSE;
    if(validParameters && count > 0) {
        
        VKRequest *requst = [VKRequest requestWithMethod:@"users.getFollowers"
                                           andParameters:@{VK_API_USER_ID : [NSString stringWithFormat:@"%@",id],
                                                           VK_API_OFFSET : [NSString stringWithFormat:@"%li",offset],
                                                           VK_API_COUNT : [NSString stringWithFormat:@"%li",count],
                                                           VK_API_FIELDS : @[VK_API_PHOTO,
                                                                             VK_API_ONLINE]}];
        [requst executeWithResultBlock:^(VKResponse *response) {
            if([response.json isKindOfClass:[NSDictionary class]]) {
                NSMutableArray *array = [NSMutableArray array];
                
                for (NSDictionary *dictionary in [response.json objectForKey:@"items"]) {
                    [array addObject:[[POOVKUserModel alloc] initWithDictionary:dictionary]];
                }
                block(array, nil);
            }
        } errorBlock:^(NSError *error) {
            block(nil, error);
        }];
    }
}

- (void)getSuggestionsWithFilter:(NSString *)filter count:(NSInteger)count offset:(NSInteger)offset block:(FriendCompletitionBlock)block {
    
    BOOL validFilter = filter.length > 0 ? TRUE : FALSE;
    BOOL validCount = count > 0 ? TRUE : FALSE;
    
    if (validFilter && validCount) {
        
        VKRequest *request = [VKRequest requestWithMethod:@"friends.getSuggestions"
                                            andParameters:@{@"filter" : filter,
                                                            VK_API_COUNT : [NSNumber numberWithInteger:count],
                                                            VK_API_OFFSET : [NSNumber numberWithInteger:offset]}];
        
        NSMutableArray *ids = [NSMutableArray array];
        [request executeWithResultBlock:^(VKResponse *response) {
            if ([response.json isKindOfClass:[NSDictionary class]]) {
                for (NSDictionary *dictonary in [response.json objectForKey:@"items"] ) {
                    [ids addObject:[dictonary objectForKey:@"id"]];
                }
                
                [self getUserInfoWithIds:ids block:^(NSArray *response, NSError *error) {
                    block(response, nil);
                }];
            }
        } errorBlock:^(NSError *error) {
            block(nil, error);
        }];
    }
}

- (void)getUserInfoWithIds:(NSArray *)friends block:(FriendCompletitionBlock)block {
    if (friends.count == 0) {
        block(@[],nil);
    }
    
    VKRequest *request = [VKRequest requestWithMethod:@"users.get"
                                        andParameters:@{VK_API_USER_IDS : [friends componentsJoinedByString:@","],
                                                        VK_API_FIELDS : @[VK_API_ONLINE,
                                                                          VK_API_PHOTO]}];
    
    NSMutableArray *users = [NSMutableArray arrayWithCapacity:friends.count];
    [request executeWithResultBlock:^(VKResponse *response) {
        if ([response.json isKindOfClass:[NSArray class]]) {
            
            for (NSDictionary *user in response.json) {
                [users addObject:[[POOVKUserModel alloc]initWithDictionary:user]];
            }
        }
        
        if (users.count > 0) {
            block([users copy], nil);
        }
        
    } errorBlock:^(NSError *error) {
        block(nil, error);
    }];
}

- (void)getInvitesWith:(BOOL)extended needMutual:(BOOL)needmMtual out:(BOOL)out block:(FriendCompletitionBlock)block {
    VKRequest *requst = [VKRequest requestWithMethod:@"friends.getRequests"
                                       andParameters:@{VK_API_EXTENDED : [NSString stringWithFormat:@"%d", extended],
                                                       @"need_mutual" : [NSString stringWithFormat:@"%d", needmMtual],
                                                       @"out" : [NSString stringWithFormat:@"%d", out]}];
    
    [requst executeWithResultBlock:^(VKResponse *response) {
        if([response.json isKindOfClass:[NSDictionary class]]) {
            
            NSMutableArray *ids = [NSMutableArray array];
            for (NSDictionary *invite in [response.json objectForKey:@"items"]) {
                [ids addObject:[invite objectForKey:@"user_id"]];
            }
            
            [self getUserInfoWithIds:ids block:^(NSArray *response, NSError *error) {
                block(response, nil);
            }];
        }
    } errorBlock:^(NSError *error) {
        block(nil, error);
    }];
}

@end
