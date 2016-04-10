//
//  SOLUserCache.h
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//

#import <Foundation/Foundation.h>
#import "SOLUserPlainObject.h"
@protocol SOLUserMapper;
@class NSPredicate;

@protocol SOLUserCache <NSObject>

- (NSArray<SOLUserPlainObject *> *)cacheExternalRepresentation:(NSArray *)items mapper:(id<SOLUserMapper>)mapper predicate:(NSPredicate *)predicate;
- (NSArray<SOLUserPlainObject *> *)cacheWithPredicate:(NSPredicate *)predicate mapper:(id<SOLUserMapper>)mapper;

@end
