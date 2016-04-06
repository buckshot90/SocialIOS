//
//  SOLMessageServiceAssembly.m
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/6/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLMessageServiceAssembly.h"

#import "SOLMessageService.h"
#import "SOLMessageServiceImplementation.h"

#import "SOLMessageTransport.h"
#import "SOLMessageTransportImplementation.h"

#import "SOLMessageMapper.h"
#import "SOLMessageMapperImplementation.h"

#import "SOLMessageCache.h"
#import "SOLMessageCacheImplementation.h"

@implementation SOLMessageServiceAssembly

+ (id<SOLMessageService>)messageService {
    
    static id <SOLMessageService> sharedService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SOLMessageServiceAssembly *assembly = [[SOLMessageServiceAssembly alloc] init];
        sharedService = [assembly p_messageService];
    });
    return sharedService;
}

- (id<SOLMessageService>)p_messageService {
    
    id <SOLMessageService> service = [[SOLMessageServiceImplementation alloc] init];
    service.transport = [[SOLMessageTransportImplementation alloc] init];
    service.mapper = [[SOLMessageMapperImplementation alloc] init];
    service.cache = [[SOLMessageCacheImplementation alloc] init];
    
    return service;
}

@end