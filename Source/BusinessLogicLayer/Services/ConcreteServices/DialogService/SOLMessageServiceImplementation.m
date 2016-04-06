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
        
        if (weakSelf && [data isKindOfClass:[NSArray class]]) {
            
            NSArray *list = (NSArray *)data;
            if (completionBlock) {
              
                completionBlock([weakSelf.cache cacheExternalRepresentation:list mapper:weakSelf.mapper predicate:predicate], nil);
            }
        } else {
            
            if (completionBlock) {
                
                completionBlock([weakSelf.cache cacheWithPredicate:predicate mapper:weakSelf.mapper], error);
            }
        }
    }];
}

- (id)obtainDialogWithPredicate:(NSPredicate *)predicate {
    
    return [self.cache cacheWithPredicate:predicate mapper:self.mapper];
}

@end
