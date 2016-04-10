//
//  SOLMessageTransport.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/6/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SOLMessageTransportCompletionBlock) (id data, NSError *error);

@protocol SOLMessageTransport <NSObject>

- (void)getDialogsWithCompletionBlock:(SOLMessageTransportCompletionBlock)completionBlock;

@end


