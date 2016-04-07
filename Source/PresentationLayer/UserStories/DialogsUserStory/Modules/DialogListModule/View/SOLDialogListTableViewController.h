//
//  DialogListTableViewController.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/4/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOLDialogListViewInput.h"
@protocol SOLDialogListViewOutput;
@class SOLDialogDataDisplayManager;

@interface SOLDialogListTableViewController : UITableViewController <SOLDialogListViewInput>

@property (strong, nonatomic) id<SOLDialogListViewOutput> output;
@property (strong, nonatomic) SOLDialogDataDisplayManager *dataDisplayManager;

@end
