//
//  SOLDialogDataDisplayManager.m
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/7/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLDialogDataDisplayManager.h"
#import "SOLDialogTableViewCellObject.h"
#import "SOLDialogTableViewCell.h"
#import "SOLDataDisplayManager.h"

@interface SOLDialogDataDisplayManager ()

@property (strong, nonatomic) NSArray<SOLDialogTableViewCellObject *> *cellObjsSearch;
@property (strong, nonatomic) NSArray<SOLDialogTableViewCellObject *> *cellObjs;
@property (strong, nonatomic) NSArray *plainObjs;
@property (assign, nonatomic) BOOL registeredNib;

@end

@implementation SOLDialogDataDisplayManager

- (void)updateTableViewModelWithPlainObjects:(NSArray *)plainObjs {
    
    self.plainObjs = plainObjs;
    self.cellObjs = [self.cellObjectBuilder cellObjectsForPlainObjects:_plainObjs];
    [self.delegate didUpdateTableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [SOLDialogTableViewCell heightForObject:_cellObjs[indexPath.row] atIndexPath:indexPath tableView:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSUInteger count = 0;
    if ([self.dataSource searchResultsController].active && ![[self.dataSource  searchResultsController].searchBar.text isEqualToString:@""]) {
        
        count = _cellObjsSearch.count;
    } else {
        
        count = _cellObjs.count;
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!_registeredNib) {
        
        self.registeredNib = YES;
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SOLDialogTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([SOLDialogTableViewCell class])];
    }
    
    SOLDialogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SOLDialogTableViewCell class])];
    
    if ([self.dataSource searchResultsController].active && ![[self.dataSource  searchResultsController].searchBar.text isEqualToString:@""]) {
        
        [cell shouldUpdateCellWithObject:_cellObjsSearch[indexPath.row]];
    } else {
        
        [cell shouldUpdateCellWithObject:_cellObjs[indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.dataSource searchResultsController].active && ![[self.dataSource  searchResultsController].searchBar.text isEqualToString:@""]) {
        
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        [self.delegate didTapCellWithDialog:_plainObjs[indexPath.row]];
    } else {
        
        [self.delegate didTapCellWithDialog:_plainObjs[indexPath.row]];
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    
    [self filterContentForSearchText:searchBar.text scope:searchBar.scopeButtonTitles[selectedScope]];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    [self filterContentForSearchText:searchController.searchBar.text scope:searchController.searchBar.scopeButtonTitles[searchController.searchBar.selectedScopeButtonIndex]];
}

#pragma mark - Filter

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dialogBody contains[cd] %@ OR dialogTitle contains[c] %@", searchText.lowercaseString, searchText.lowercaseString];
    self.cellObjsSearch = [_cellObjs filteredArrayUsingPredicate:predicate];
    [self.delegate didUpdateTableView];
}

//func filterContentForSearchText(searchText: String, scope: String = "All") {
//    filteredCandies = candies.filter({( candy : Candy) -> Bool in
//        let categoryMatch = (scope == "All") || (candy.category == scope)
//        return categoryMatch && candy.name.lowercaseString.containsString(searchText.lowercaseString)
//    })
//    tableView.reloadData()
//}

@end
