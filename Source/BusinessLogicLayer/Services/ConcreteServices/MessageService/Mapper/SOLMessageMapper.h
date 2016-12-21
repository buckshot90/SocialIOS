//
//  SOLMessageMapper.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/6/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Message.h"
#import "SOLMessagePlainObject.h"

@protocol SOLMessageMapper <NSObject>

- (SOLMessagePlainObject *)objectFromExternalRepresentation:(NSDictionary *)dictionary;
- (NSArray<SOLMessagePlainObject *> *)arrayFromExternalRepresentation:(NSArray *)array;

@end
