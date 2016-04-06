//
//  SOLMessageCache.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/6/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"
#import "SOLMessagePlainObject.h"
#import "SOLMessageMapper.h"

@protocol SOLMessageCache <NSObject>

- (NSArray<SOLMessagePlainObject *> *)cacheExternalRepresentation:(NSArray *)messages mapper:(id<SOLMessageMapper>)mapper predicate:(NSPredicate *)predicate;
- (NSArray<SOLMessagePlainObject *> *)cacheWithPredicate:(NSPredicate *)predicate mapper:(id<SOLMessageMapper>)mapper;

@end
