//
//  SOLBaseDataDisplayManager.m
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//

#import "SOLBaseDataDisplayManager.h"

@implementation SOLBaseDataDisplayManager

- (void)updateTableViewModelWithPlainObjects:(NSArray *)plainObjs {
    
    self.plainObjs = plainObjs;
    self.cellObjs = [self.cellObjectBuilder cellObjectsForPlainObjects:self.plainObjs];
    [self.delegate didUpdateTableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

- (void)filterContentForPredicate:(NSPredicate *)predicate {
    
    self.cellObjsSearch = [self.cellObjs filteredArrayUsingPredicate:predicate];
    [self.delegate didUpdateTableView];
}

@end
