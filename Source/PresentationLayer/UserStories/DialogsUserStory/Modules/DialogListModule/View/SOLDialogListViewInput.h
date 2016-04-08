//
//  SOLDialogListViewInput.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/4/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SOLMessagePlainObject;

@protocol SOLDialogListViewInput <NSObject>

- (void)setupViewWithDialogList:(NSArray<SOLMessagePlainObject *> *)dialogs;
- (void)updateViewWithDialogList:(NSArray<SOLMessagePlainObject *> *)dialogs;

@end
