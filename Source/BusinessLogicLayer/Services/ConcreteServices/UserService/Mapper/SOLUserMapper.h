//
//  SOLUserMapper.h
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SOLUserPlainObject;

@protocol SOLUserMapper <NSObject>

- (SOLUserPlainObject *)objectFromExternalRepresentation:(NSDictionary *)dictionary;
- (NSArray<SOLUserPlainObject *> *)arrayFromExternalRepresentation:(NSArray *)array;

@end
