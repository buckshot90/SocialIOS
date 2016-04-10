//
//  SOLDialogListInteractor.m
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/4/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLDialogListInteractor.h"
#import "SOLDialogListInteractorOutput.h"

@implementation SOLDialogListInteractor

#pragma mark - SOLDialogListInteractorInput

- (void)updateDialogList {
    
    typeof(self) __weak weakSelf = self;
    [self.messageService updateMessagesWithPredicate:nil completionBlock:^(NSArray<SOLMessagePlainObject *> *list, NSError *error) {
        
        typeof(self) __strong strongSelf = weakSelf;
        NSArray<SOLMessagePlainObject *> *sortedMessages = [strongSelf sortByDateWithMessages:list];
        [strongSelf.output didUpdateDialogList:sortedMessages];
    }];
}

- (NSArray<SOLMessagePlainObject *> *)obtainDialogList {
    
    NSArray<SOLMessagePlainObject *> *messages = [self.messageService obtainMessagesWithPredicate:nil];
    return [self sortByDateWithMessages:messages];
}

#pragma mark - Private methods

- (NSArray<SOLMessagePlainObject *> *)sortByDateWithMessages:(NSArray<SOLMessagePlainObject *> *)messages {
    
    NSArray<SOLMessagePlainObject *> *sortedMessages;
    sortedMessages = [messages sortedArrayUsingComparator:^NSComparisonResult(SOLMessagePlainObject *  _Nonnull obj1, SOLMessagePlainObject *  _Nonnull obj2) {
        
        return [[NSDate dateWithTimeIntervalSince1970:obj2.date.doubleValue]  compare:[NSDate dateWithTimeIntervalSince1970:obj1.date.doubleValue]];
    }];
    
    return sortedMessages;
}

@end
