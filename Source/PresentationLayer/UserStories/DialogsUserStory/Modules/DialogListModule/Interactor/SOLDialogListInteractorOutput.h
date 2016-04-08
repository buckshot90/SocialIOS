//
//  DialogListInteractorOutput.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/4/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SOLMessagePlainObject;

@protocol SOLDialogListInteractorOutput <NSObject>

- (void)didUpdateDialogList:(NSArray<SOLMessagePlainObject *> *)dialogs;

@end
