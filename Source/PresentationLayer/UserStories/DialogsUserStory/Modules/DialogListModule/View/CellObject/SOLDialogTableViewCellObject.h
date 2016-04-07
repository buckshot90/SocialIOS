//
//  SOLDialogTableViewCellObject.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/7/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SOLMessagePlainObject;

@interface SOLDialogTableViewCellObject : NSObject

@property (strong, nonatomic, readonly) NSString *dialogTitle;
@property (strong, nonatomic, readonly) NSString *dialogBody;
@property (strong, nonatomic, readonly) NSURL *dialogThumbnailUrl;
@property (strong, nonatomic, readonly) NSString *dialogDate;

+ (instancetype)objectWithMessage:(SOLMessagePlainObject *)message;

@end
