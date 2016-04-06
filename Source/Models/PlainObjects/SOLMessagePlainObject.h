//
//  SOLDialogPlainObject.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/4/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOLMessagePlainObject : NSObject

@property (copy, nonatomic) NSString *body;
@property (copy, nonatomic) NSDate *date;
@property (copy, nonatomic) NSString *guid;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSNumber *readState;

@end
