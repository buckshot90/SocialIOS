//
//  SOLUserTransportImplementation.m
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLUserTransportImplementation.h"
#import "SOLUserTransport.h"
#import <VK_ios_sdk/VKSdk.h>

@implementation SOLUserTransportImplementation

- (void)getFriendsWithCompletionBlopck:(SOLUserTransportCompletionBlock)completionBlock {
    
    VKRequest *getUsers = [VKRequest requestWithMethod:@"friends.get" parameters:@{VK_API_COUNT: @200, VK_API_ORDER: @"hints", VK_API_FIELDS: @"nickname, domain, sex, bdate, city, country, timezone, photo_50, photo_100, photo_200_orig, has_mobile, contacts, education, online, relation, last_seen, status, can_write_private_message, can_see_all_posts, can_post, universities"}];
    [getUsers executeWithResultBlock:^(VKResponse *response) {
        
        if ([response.json isKindOfClass:[NSDictionary class]]) {
            
            if ([[response.json objectForKey:@"items"] isKindOfClass:[NSArray class]]) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    completionBlock([[response.json objectForKey:@"items"] copy], nil);
                });
            }
        }
        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"Error: %@", error);
        completionBlock(nil, error);
    }];
}

@end
