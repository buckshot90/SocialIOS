//
//  SOLUserTransport.h
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//

#import <Foundation/Foundation.h>

typedef void (^SOLUserTransportCompletionBlock)(id data, NSError *error);

@protocol SOLUserTransport <NSObject>

- (void)getFriendsWithCompletionBlopck:(SOLUserTransportCompletionBlock)completionBlock;

@end
