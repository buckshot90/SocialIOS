//
//  SOLDialogDataDisplayManager.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/7/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOLDataDisplayManager.h"
#import "SOLCellObjectBuilder.h"

@class SOLMessagePlainObject;

@protocol SOLDialogDataDisplayManagerDataSource

- (UISearchController *)searchResultsController;

@end

@protocol SOLDialogDataDisplayManagerDelegate

- (void)didUpdateTableView;
- (void)didTapCellWithDialog:(SOLMessagePlainObject *)dialog;

@end

@interface SOLDialogDataDisplayManager : NSObject <SOLDataDisplayManager, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating>

@property (strong, nonatomic) id<SOLCellObjectBuilder> cellObjectBuilder;
@property (weak, nonatomic) id<SOLDialogDataDisplayManagerDelegate> delegate;
@property (weak, nonatomic) id<SOLDialogDataDisplayManagerDataSource> dataSource;

- (void)updateTableViewModelWithPlainObjects:(NSArray *)plainObjs;

@end
