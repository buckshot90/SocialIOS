//
//  SOLDataDisplayManager.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/7/16.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SOLPlainObject.h"

@protocol SOLDataDisplayManagerDataSource

- (UISearchController *)searchResultsController;

@end

@protocol SOLDataDisplayManagerDelegate

- (void)didUpdateTableView;
- (void)didTapCellWithPlainObject:(id<SOLPlainObject>)plainObj;

@end

@protocol SOLDataDisplayManager <NSObject>

- (void)updateTableViewModelWithPlainObjects:(NSArray *)plainObjs;
- (void)filterContentForPredicate:(NSPredicate *)predicate;
//- (id<UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView;
//- (id<UITableViewDelegate>)delegateForTableView:(UITableView *)tableView;

@end
