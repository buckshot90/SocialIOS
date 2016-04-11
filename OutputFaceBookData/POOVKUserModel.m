//
//  POOVKUserModel.m
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 14.01.16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "POOVKUserModel.h"

@implementation POOVKUserModel

- (POOVKUserModel *) initWithDictionary:(NSDictionary *)dictionary {
    
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        
        _name = [dictionary objectForKey:@"first_name"];
        _lastName = [dictionary objectForKey:@"last_name"];
        id objectOnline = [dictionary objectForKey:@"online"];
        if ([objectOnline isKindOfClass:[NSNumber class]]) {
            
            _online = ((NSNumber *)objectOnline).boolValue;
        }
        _image = [dictionary objectForKey:@"photo"];
        
        return self;
    }
    return nil;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Name:%@\n LastName:%@",_name, _lastName];
}

@end
