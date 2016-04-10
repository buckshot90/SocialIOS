//
//  SOLUserService.h
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//

#import <Foundation/Foundation.h>

@class SOLUserPlainObject;
@class NSPredicate;

typedef void (^SOLUserCompletionBlock) (NSArray<SOLUserPlainObject *> * list, NSError *error);

@protocol SOLUserService <NSObject>

- (NSArray<SOLUserPlainObject *> *)obtainUsersWithPredicate:(NSPredicate *)predicate;
- (void)updateUsersWithPredicate:(NSPredicate *)predicate completionBlock:(SOLUserCompletionBlock)completionBlock;

@end
