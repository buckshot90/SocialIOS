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
            
            for (SOLMessagePlainObject *plain in [mapper arrayFromExternalRepresentation:messages]) {
                
                Message *managed = [Message MR_findFirstOrCreateByAttribute:@"guid" withValue:plain.guid inContext:localContext];
                if (managed == nil) {
                    
                    managed = [Message MR_createEntityInContext:localContext];
                }
                
                if(plain) {
                    
                    managed.title = plain.title;
                    managed.body = plain.body;
                    managed.guid = plain.guid;
                    managed.userId = plain.userId;
                    managed.readState = plain.readState;
                    managed.date = plain.date;
                }
            }
        }];
    }
    
    NSArray *managedObjects = predicate ? [Message MR_findAllWithPredicate:predicate] : [Message MR_findAll];
    
    NSMutableArray<SOLMessagePlainObject *> *list = [[NSMutableArray<SOLMessagePlainObject *> alloc] initWithCapacity:managedObjects.count];
    for (Message *managed in managedObjects) {
        
        SOLMessagePlainObject *plain = [SOLMessagePlainObject new];
        if(managed) {
            
            plain.title = managed.title;
            plain.body = managed.body;
            plain.guid = managed.guid;
            plain.userId = managed.userId;
            plain.readState = managed.readState;
            plain.date = managed.date;
        }
        [list addObject:plain];
    }
    
    return list;
}

- (NSArray<SOLMessagePlainObject *> *)cacheWithPredicate:(NSPredicate *)predicate mapper:(id<SOLMessageMapper>)mapper {
    
    return [self cacheExternalRepresentation:nil mapper:mapper predicate:predicate];
}

@end
