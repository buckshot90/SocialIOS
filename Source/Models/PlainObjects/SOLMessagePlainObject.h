//
//  SOLDialogPlainObject.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/4/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOLPlainObject.h"

@interface SOLMessagePlainObject : NSObject

@property (nullable, copy, nonatomic, readwrite) NSString *guid;
@property (nullable, copy, nonatomic, readwrite) NSString *body;
@property (nullable, copy, nonatomic, readwrite) NSNumber *date;
@property (nullable, copy, nonatomic, readwrite) NSString *title;
@property (nullable, copy, nonatomic, readwrite) NSString *userId;
@property (nullable, copy, nonatomic, readwrite) NSNumber *readState;

@end
