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

@property (strong, nonatomic) id <SOLMessageMapper> mapper;
@property (strong, nonatomic) id <SOLMessageTransport> transport;
@property (strong, nonatomic) id <SOLMessageCache> cache;

- (id)obtainDialogWithPredicate:(NSPredicate *)predicate;
- (void)updateDialogWithPredicate:(NSPredicate *)predicate completionBlock:(SOLMessageCompletionBlock)completionBlock;

@end
