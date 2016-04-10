//
//  SOLMessageSerializer.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/6/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Message.h"
#import "SOLMessagePlainObject.h"

@protocol SOLMessageSerializer <NSObject>

- (NSDictionary *)serializeManagedObject:(Message *)managedObject;
- (NSArray *)serializeCollectionOfManagedObjects:(NSArray<Message *> *)managedObjects;
- (NSDictionary *)serializePlainObject:(SOLMessagePlainObject *)plainObject;
- (NSArray *)serializeCollectionOfPlainObjects:(NSArray<SOLMessagePlainObject *> *)plainObjects;

@end
