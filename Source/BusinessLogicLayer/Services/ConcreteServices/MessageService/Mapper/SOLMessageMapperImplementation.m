//
//  SOLMessageMapperImplementation.m
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/6/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLMessageMapperImplementation.h"

#import "Message.h"
#import <MagicalRecord/MagicalRecord.h>

#import "SOLMessagePlainObject.h"

@implementation SOLMessageMapperImplementation

- (SOLMessagePlainObject *)objectFromExternalRepresentation:(NSDictionary *)dictionary {
    
    SOLMessagePlainObject *plain = [SOLMessagePlainObject new];
    if(dictionary) {
        
        plain.title = [[dictionary objectForKey:@"message"] objectForKey:@"title"];
        plain.body = [[dictionary objectForKey:@"message"] objectForKey:@"body"];
        
        id guid = [[dictionary objectForKey:@"message"] objectForKey:@"id"];
        if([guid isKindOfClass:[NSString class]]) {
            
            plain.guid = (NSString *)guid;
        } else if([guid isKindOfClass:[NSNumber class]]) {
            
            plain.guid = ((NSNumber *)guid).stringValue;
        } else {
            
            //should stop
        }
        
        plain.userId = [[dictionary objectForKey:@"message"] objectForKey:@"userId"];
        plain.readState = [[dictionary objectForKey:@"message"] objectForKey:@"readState"];
        
        id date = [[dictionary objectForKey:@"message"] objectForKey:@"date"];
        if([date isKindOfClass:[NSNumber class]]) {
            
            plain.date = (NSNumber *)date; 
        } else {
            
            //should stop
        }
    }
    
    return plain;
}

- (NSArray<SOLMessagePlainObject *> *)arrayFromExternalRepresentation:(NSArray *)array {
    
    NSMutableArray<SOLMessagePlainObject *> *list = [[NSMutableArray<SOLMessagePlainObject *> alloc] initWithCapacity:array.count];
    for (NSDictionary *external in array) {
        
        [list addObject:[self objectFromExternalRepresentation:external]];
    }
    
    return list;
}

- (SOLMessagePlainObject *)objectFromManagedObject:(Message *)managedObject {
    
    SOLMessagePlainObject *plain = [SOLMessagePlainObject new];
    if(managedObject) {
        
        plain.title = managedObject.title;
        plain.body = managedObject.body;
        plain.guid = managedObject.guid;
        plain.userId = managedObject.userId;
        plain.readState = managedObject.readState;
        plain.date = managedObject.date;
    }
    
    return plain;
}

- (NSArray<SOLMessagePlainObject *> *)arrayFromManagedObject:(NSArray<Message *> *)managedObjects {
    
    NSMutableArray<SOLMessagePlainObject *> *list = [[NSMutableArray<SOLMessagePlainObject *> alloc] initWithCapacity:managedObjects.count];
    for (Message *managed in managedObjects) {
        
        [list addObject:[self objectFromManagedObject:managed]];
    }
    
    return list;
}

- (Message *)objectFromPlainObject:(SOLMessagePlainObject *)plainObject {
    Message *managed = [Message MR_findFirstOrCreateByAttribute:@"guid" withValue:plainObject.guid];
    if(plainObject) {
        
        managed.title = plainObject.title;
        managed.body = plainObject.body;
        managed.guid = plainObject.guid;
        managed.userId = plainObject.userId;
        managed.readState = plainObject.readState;
        managed.date = plainObject.date;
    }
    
    return managed;
}

- (NSArray<Message *> *)arrayFromPlainObject:(NSArray<SOLMessagePlainObject *> *)plainObjects {
    
    NSMutableArray<Message *> *list = [[NSMutableArray<Message *> alloc] initWithCapacity:plainObjects.count];
    for (SOLMessagePlainObject *plain in plainObjects) {
        
        [list addObject:[self objectFromPlainObject:plain]];
    }
    
    return list;
}

@end
