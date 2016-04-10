//
//  SOLFriendListDataDisplayManager.m
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLFriendListDataDisplayManager.h"
#import "SOLFriendListTableViewCell.h"

@implementation SOLFriendListDataDisplayManager

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [SOLFriendListTableViewCell heightForObject:self.cellObjs[indexPath.row] atIndexPath:indexPath tableView:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSUInteger count = 0;
    if ([self.dataSource searchResultsController].active && ![[self.dataSource  searchResultsController].searchBar.text isEqualToString:@""]) {
        
        count = self.cellObjsSearch.count;
    } else {
        
        count = self.cellObjs.count;
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!self.registeredNib) {
        
        self.registeredNib = YES;
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SOLFriendListTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([SOLFriendListTableViewCell class])];
    }
    
    SOLFriendListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SOLFriendListTableViewCell class])];
    
    if ([self.dataSource searchResultsController].active && ![[self.dataSource  searchResultsController].searchBar.text isEqualToString:@""]) {
        
        [cell shouldUpdateCellWithObject:self.cellObjsSearch[indexPath.row]];
    } else {
        
        [cell shouldUpdateCellWithObject:self.cellObjs[indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.dataSource searchResultsController].active && ![[self.dataSource  searchResultsController].searchBar.text isEqualToString:@""]) {
        
        //        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        //        [self.delegate didTapCellWithDialog:_plainObjs[indexPath.row]];
    } else {
        
        [self.delegate didTapCellWithPlainObject:self.plainObjs[indexPath.row]];
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    
    NSString *searchText = searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userName contains[cd] %@", searchText.lowercaseString];
    //    scope:searchBar.scopeButtonTitles[selectedScope]
    [self filterContentForPredicate:predicate];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchText = searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userName contains[cd] %@", searchText.lowercaseString];
    [self filterContentForPredicate:predicate];
}

@end
