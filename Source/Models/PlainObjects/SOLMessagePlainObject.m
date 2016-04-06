//
//  SOLDialogPlainObject.m
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/4/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLMessagePlainObject.h"

@implementation SOLMessagePlainObject

- (NSString *)description {
    
    return [NSString stringWithFormat:@"body: %@", self.body];
}

@end
