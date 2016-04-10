//
//  SOLDialogService.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/4/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOLMessageService.h"

@interface SOLMessageServiceImplementation : NSObject <SOLMessageService>

@property (strong, nonatomic) id <SOLMessageMapper> mapper;
@property (strong, nonatomic) id <SOLMessageTransport> transport;
@property (strong, nonatomic) id <SOLMessageCache> cache;

@end
