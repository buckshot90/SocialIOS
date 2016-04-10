//
//  SOLDialogTableViewCellObject.m
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/7/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLDialogTableViewCellObject.h"
#import "SOLMessagePlainObject.h"
#import "SOLDialogTableViewCell.h"

@interface SOLDialogTableViewCellObject ()

@property (strong, nonatomic, readwrite) NSString *dialogTitle;
@property (strong, nonatomic, readwrite) NSString *dialogBody;
@property (strong, nonatomic, readwrite) NSURL *dialogThumbnailUrl;
@property (strong, nonatomic, readwrite) NSString *dialogDate;

@end

@implementation SOLDialogTableViewCellObject

- (instancetype)initWithMessage:(SOLMessagePlainObject *)message {
    
    self = [super init];
    if (self) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm"];
        _dialogDate = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970: message.date.doubleValue]];
        
        _dialogTitle = message.title;
        _dialogBody = message.body;
        _dialogThumbnailUrl = [NSURL URLWithString:@"http://cs628217.vk.me/v628217628/47895/ekTbirVjm5U.jpg"];
    }
    return self;
}

+ (instancetype)objectWithMessage:(SOLMessagePlainObject *)message {
    
    return [[self alloc] initWithMessage:message];
}

#pragma mark - CellObject methods

- (Class)cellClass {
    
    return [SOLDialogTableViewCell class];
}

- (UINib *)cellNib {
    
    return [UINib nibWithNibName:NSStringFromClass([SOLDialogTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
