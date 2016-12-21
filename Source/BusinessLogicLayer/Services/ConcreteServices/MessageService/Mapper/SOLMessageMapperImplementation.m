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

@end
