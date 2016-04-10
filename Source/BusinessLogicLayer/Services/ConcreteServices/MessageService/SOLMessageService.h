//
//  SOLDialogService.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/6/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOLMessageMapper.h"
#import "SOLMessageTransport.h"
#import "SOLMessageCache.h"

@class NSPredicate;

typedef void (^SOLMessageCompletionBlock) (NSArray<SOLMessagePlainObject *> * list, NSError *error);

@protocol SOLMessageService <NSObject>

- (NSArray<SOLMessagePlainObject *> *)obtainMessagesWithPredicate:(NSPredicate *)predicate;
- (void)updateMessagesWithPredicate:(NSPredicate *)predicate completionBlock:(SOLMessageCompletionBlock)completionBlock;

@end
