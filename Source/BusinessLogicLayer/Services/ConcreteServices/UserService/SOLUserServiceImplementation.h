//
//  SOLUserServiceImplementation.h
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SOLUserService.h"
#import "SOLUserTransport.h"
#import "SOLUserMapper.h"
#import "SOLUserCache.h"

@interface SOLUserServiceImplementation : NSObject <SOLUserService>

@property (strong, nonatomic) id <SOLUserMapper> mapper;
@property (strong, nonatomic) id <SOLUserTransport> transport;
@property (strong, nonatomic) id <SOLUserCache> cache;

@end
