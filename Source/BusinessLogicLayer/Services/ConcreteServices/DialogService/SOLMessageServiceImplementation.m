//
//  SOLDialogService.m
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/4/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLMessageServiceImplementation.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation SOLMessageServiceImplementation

@synthesize transport = _transport, mapper = _mapper, cache = _cache;

- (void)updateDialogWithPredicate:(NSPredicate *)predicate completionBlock:(SOLMessageCompletionBlock)completionBlock {
    
    typeof(self) __weak weakSelf = self;
    [self.transport getDialogsWithCompletionBlock:^(id data, NSError *error) {
        typeof(self) __strong strongSelf = weakSelf;
        
        if (strongSelf && [data isKindOfClass:[NSArray class]]) {
            
            NSArray *list = (NSArray *)data;
            if (completionBlock) {
              
                completionBlock([strongSelf.cache cacheExternalRepresentation:list mapper:strongSelf.mapper predicate:predicate], nil);
            }
        } else {
            
            if (completionBlock) {
                
                completionBlock([strongSelf.cache cacheWithPredicate:predicate mapper:strongSelf.mapper], error);
            }
        }
    }];
}

- (id)obtainDialogWithPredicate:(NSPredicate *)predicate {
    
    return [self.cache cacheWithPredicate:predicate mapper:self.mapper];
}

@end
