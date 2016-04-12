//
//  SOLMessageCacheImplementation.m
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/6/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLMessageCacheImplementation.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation SOLMessageCacheImplementation

- (NSArray<SOLMessagePlainObject *> *)cacheExternalRepresentation:(NSArray *)messages mapper:(id<SOLMessageMapper>)mapper predicate:(NSPredicate *)predicate {
    
    if (messages.count > 0) {
        
        [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
            
            [mapper arrayFromPlainObject:[mapper arrayFromExternalRepresentation:messages]];
        }];
    }
    
    NSArray *dialogs = predicate ? [Message MR_findAllWithPredicate:predicate] : [Message MR_findAll];
    return [mapper arrayFromManagedObject:dialogs];
}

- (NSArray<SOLMessagePlainObject *> *)cacheWithPredicate:(NSPredicate *)predicate mapper:(id<SOLMessageMapper>)mapper {
    
    return [self cacheExternalRepresentation:nil mapper:mapper predicate:predicate];
}

@end