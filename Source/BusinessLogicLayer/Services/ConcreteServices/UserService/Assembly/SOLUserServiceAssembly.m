//
//  SOLUserServiceAssembly.m
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLUserServiceAssembly.h"
#import "SOLUserService.h"
#import "SOLUserServiceImplementation.h"
#import "SOLUserTransportImplementation.h"
#import "SOLUserMapperImplementation.h"
#import "SOLUserCacheImplementation.h"

@implementation SOLUserServiceAssembly

+ (id<SOLUserService>)userService {
    
    SOLUserServiceImplementation *service = [[SOLUserServiceImplementation alloc] init];
    service.transport = [SOLUserTransportImplementation new];
    service.cache = [SOLUserCacheImplementation new];
    service.mapper = [SOLUserMapperImplementation new];
    
    return service;
}

@end
