//
//  SOLMessageServiceAssembly.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/6/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOLMessageService.h"

@interface SOLMessageServiceAssembly : NSObject

+ (id<SOLMessageService>)messageService;

@end
