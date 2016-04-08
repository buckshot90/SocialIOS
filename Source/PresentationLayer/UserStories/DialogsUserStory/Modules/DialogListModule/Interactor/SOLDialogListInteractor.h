//
//  SOLDialogListInteractor.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/4/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOLDialogListInteractorInput.h"

#import "SOLMessageService.h"

@protocol SOLDialogListInteractorOutput;

@interface SOLDialogListInteractor : NSObject <SOLDialogListInteractorInput>

@property (weak, nonatomic) id <SOLDialogListInteractorOutput> output;
@property (strong, nonatomic) id <SOLMessageService> messageService;

@end
