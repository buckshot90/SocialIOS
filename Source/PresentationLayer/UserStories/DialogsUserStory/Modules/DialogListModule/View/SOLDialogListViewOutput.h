//
//  SOLDialogListViewOutput.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/4/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SOLMessagePlainObject;

@protocol SOLDialogListViewOutput <NSObject>

- (void)setupView;
- (void)refreshData;
- (void)didTriggerTapCellWithMessage:(SOLMessagePlainObject *)message;

@end
