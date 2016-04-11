//
//  SOLMessageTransportImplementation.m
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/6/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLMessageTransportImplementation.h"
#import <VK_ios_sdk/VKSdk.h>

@implementation SOLMessageTransportImplementation

- (void)getDialogsWithCompletionBlock:(SOLMessageTransportCompletionBlock)completionBlock {
    
    VKRequest *getMessages = [VKRequest requestWithMethod:@"messages.getDialogs" andParameters:@{VK_API_COUNT: @200}];
    [getMessages executeWithResultBlock:^(VKResponse *response) {
        
        if ([response.json isKindOfClass:[NSDictionary class]]) {
            
            if ([[response.json objectForKey:@"items"] isKindOfClass:[NSArray class]]) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    completionBlock([[response.json objectForKey:@"items"] copy], nil);
//                    NSLog(@"Message json: %@", [response.json objectForKey:@"items"]);
                });
            }
        }
        
    } errorBlock:^(NSError *error) {
        NSLog(@"Error: %@", error);
        completionBlock(nil, error);
    }];
}

@end
