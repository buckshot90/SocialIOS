//
//  SOLUserPlainObject.m
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/3/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLUserPlainObject.h"

@implementation SOLUserPlainObject

- (NSString *)description {
    
    return [NSString stringWithFormat:@"name: %@", self.firstName];
}

@end
