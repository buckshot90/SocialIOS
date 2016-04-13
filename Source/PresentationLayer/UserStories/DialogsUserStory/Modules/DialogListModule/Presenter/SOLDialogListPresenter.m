//
//  SOLDialogListPresenter.m
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/4/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLDialogListPresenter.h"
#import "SOLDialogListViewInput.h"
#import "SOLDialogListInteractorInput.h"

@implementation SOLDialogListPresenter

#pragma mark - SOLDialogListInteractorOutput

- (void)didUpdateDialogList:(NSArray<SOLMessagePlainObject *> *)dialogs {
    
    [self.view updateViewWithDialogList:dialogs];
}

#pragma mark - SOLDialogListViewOutput

- (void)refreshData {
    
     [self.interactor updateDialogList];
}

- (void)setupView {
    
    NSArray<SOLMessagePlainObject *> * dialogs = [self.interactor obtainDialogList];
    [self.interactor updateDialogList];
    [self.view setupViewWithDialogList:dialogs];
}

- (void)didTriggerTapCellWithMessage:(SOLMessagePlainObject *)message {
  
//    [self.router ]
}

@end
