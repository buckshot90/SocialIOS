//
//  SOLUserServiceAssembly.h
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SOLUserService;

@interface SOLUserServiceAssembly : NSObject

+ (id<SOLUserService>)userService;

@end
