//
//  SOLDialogListPresenter.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/4/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOLDialogListInteractorOutput.h"
#import "SOLDialogListViewOutput.h"
@protocol SOLDialogListViewInput;
@protocol SOLDialogListInteractorInput;
@protocol SOLDialogListRouterInput;

@interface SOLDialogListPresenter : NSObject <SOLDialogListInteractorOutput, SOLDialogListViewOutput>

@property (weak, nonatomic) id<SOLDialogListViewInput> view;
@property (strong, nonatomic) id<SOLDialogListInteractorInput> interactor;
@property (strong, nonatomic) id<SOLDialogListRouterInput> router;

@end
