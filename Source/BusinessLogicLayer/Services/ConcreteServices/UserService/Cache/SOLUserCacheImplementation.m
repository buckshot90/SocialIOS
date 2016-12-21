//
//  SOLUserCacheImplementation.m
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLUserCacheImplementation.h"
#import <MagicalRecord/MagicalRecord.h>
#import "SOLUserMapper.h"
#import "SOLUserPlainObject.h"
#import "User.h"

//@property (nullable, copy, nonatomic, readwrite) NSString *guid;
//@property (nullable, copy, nonatomic, readwrite) NSString *firstName;
//@property (nullable, copy, nonatomic, readwrite) NSString *lastName;
//@property (nullable, copy, nonatomic, readwrite) NSString *nickName;
//@property (nullable, copy, nonatomic, readwrite) NSString *photoLow;
//@property (nullable, copy, nonatomic, readwrite) NSString *photoOrign;
//@property (nullable, copy, nonatomic, readwrite) NSString *photoMiddle;
//@property (nullable, copy, nonatomic, readwrite) NSString *mobilePhone;
//@property (assign, nonatomic, readwrite) BOOL online;
//@property (assign, nonatomic, readwrite) BOOL onlineMobile;

@implementation SOLUserCacheImplementation

- (NSArray<SOLUserPlainObject *> *)cacheExternalRepresentation:(NSArray *)items mapper:(id<SOLUserMapper>)mapper predicate:(NSPredicate *)predicate {
    
    if (items.count > 0) {
        
        [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
            
            for (SOLUserPlainObject *plain in [mapper arrayFromExternalRepresentation:items]) {
                
                User *manage = [User MR_findFirstOrCreateByAttribute:@"guid" withValue:plain.guid inContext:localContext];
                if (manage == nil) {
                    
                    manage = [User MR_createEntityInContext:localContext];
                }
                
                manage.guid = plain.guid;
                manage.firstName = plain.firstName;
                manage.lastName = plain.lastName;
                manage.nickName = plain.nickName;
                manage.phoneMobile = plain.mobilePhone;
                manage.photoOrign = plain.photoOrign;
                manage.photoLow = plain.photoLow;
                manage.photoMiddle = plain.photoMiddle;
            }
        }];
    }
    
    NSArray *managedItems = predicate ? [User MR_findAllWithPredicate:predicate] : [User MR_findAll];
    
    NSMutableArray<SOLUserPlainObject *> *plainList = [NSMutableArray<SOLUserPlainObject *> new];
    for (User *manage in managedItems) {
        
        SOLUserPlainObject *plain = [SOLUserPlainObject new];
        plain.guid = manage.guid;
        plain.firstName = manage.firstName;
        plain.lastName = manage.lastName;
        plain.nickName = manage.nickName;
        plain.mobilePhone = manage.phoneMobile;
        plain.photoOrign = manage.photoOrign;
        plain.photoLow = manage.photoLow;
        plain.photoMiddle = manage.phoneMobile;
        
        [plainList addObject:plain];
    }
    
    return plainList;
}

- (NSArray<SOLUserPlainObject *> *)cacheWithPredicate:(NSPredicate *)predicate mapper:(id)mapper {
    
    return [self cacheExternalRepresentation:nil mapper:mapper predicate:predicate];
}

@end
