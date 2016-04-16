//
//  ContactsViewController.m
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 13.04.16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "POOContactsViewController.h"
#import "POOContactServiceImplementation.h"
#import "POOPhoneBookContact.h"
#import "POOVKTableViewCell.h"
#import "POOContactInfoViewController.h"

static NSString *MyIdentifier = @"ContactCellIdentefier";

@interface POOContactsViewController () <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (strong, nonatomic) NSDictionary *searchContacts;
@property (strong, nonatomic) NSDictionary *contactsBySections;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation POOContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchContacts = [NSDictionary dictionary];
    self.contactsBySections = [NSDictionary dictionary];
    
    [self buildUI];
    
    self.contactsBySections = [self getSortedArrayBySection:_contacts];
}

- (NSDictionary *)getSortedArrayBySection:(NSArray *)array {
    NSMutableArray *sectionsKey = [[NSMutableArray alloc] init];
    NSMutableDictionary *contactsBySections = [NSMutableDictionary dictionary];
    
    for (POOPhoneBookContact *contact in array) {
        [self creatArrayPhoneBookContacts:contact sectionsKey:sectionsKey contactsBySections:contactsBySections];
    }
    [sectionsKey sortUsingSelector:@selector(caseInsensitiveCompare:)];
    
    return contactsBySections;
}

- (void)creatArrayPhoneBookContacts:(POOPhoneBookContact *)contact sectionsKey:(NSMutableArray *)sectionsKey contactsBySections:(NSMutableDictionary *)contactsBySections {
    NSString *sectionName = [contact.name substringToIndex:1];
    NSMutableArray *nameInSection = nil;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", sectionName];
    NSArray *foundSection = [sectionsKey filteredArrayUsingPredicate:predicate];
    
    if (foundSection.count) {
        nameInSection = [contactsBySections objectForKey:sectionName];
    } else {
        nameInSection = [NSMutableArray array];
        [sectionsKey addObject:sectionName];
    }
    
    [nameInSection addObject:contact];
    [contactsBySections setObject:nameInSection forKey:sectionName];
}

#pragma mark - TableView DataSource and Delegat
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (![self.searchController.searchBar.text isEqualToString:@""]) {
        
        return self.searchContacts.allKeys.count;
    }
    return self.contactsBySections.allKeys.count ;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = nil;
    
    if (![self.searchController.searchBar.text isEqualToString:@""]) {
        
        array = self.searchContacts.allKeys;
        return [[self.searchContacts objectForKey:[array objectAtIndex:section]] count];
    }
    array = self.contactsBySections.allKeys;
    return [[self.contactsBySections objectForKey:[array objectAtIndex:section]] count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (![self.searchController.searchBar.text isEqualToString:@""]) {
        
        return  [self.searchContacts.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    }
    return [self.contactsBySections.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (![self.searchController.searchBar.text isEqualToString:@""]) {
        
         return [self.searchContacts.allKeys objectAtIndex:section];
    }
    return [self.contactsBySections.allKeys objectAtIndex:section];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    POOVKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"POOVKTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    POOPhoneBookContact *phoneContact = nil;
    
    if (![self.searchController.searchBar.text isEqualToString:@""]) {
        NSString *curentKey = [self.searchContacts.allKeys objectAtIndex:indexPath.section];
        NSArray * currentNames = [self.searchContacts objectForKey:curentKey];
        phoneContact = [currentNames objectAtIndex:indexPath.row];
    }
    
    NSString *curentKey = [self.contactsBySections.allKeys objectAtIndex:indexPath.section];
    NSArray * currentNames = [self.contactsBySections objectForKey:curentKey];
     phoneContact = [currentNames objectAtIndex:indexPath.row];
    
    [cell configureWithName:phoneContact.name SecondName:phoneContact.secondName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
        NSString *curentKey = [self.contactsBySections.allKeys objectAtIndex:indexPath.section];
        NSArray * currentNames = [self.contactsBySections objectForKey:curentKey];
        POOPhoneBookContact *phoneContact = [currentNames objectAtIndex:indexPath.row];
        
        POOContactInfoViewController *contactInfoController = [[POOContactInfoViewController alloc] initWithName:phoneContact.name lastName:phoneContact.secondName phones:phoneContact.phones];
        
        [self.navigationController pushViewController:contactInfoController animated:YES];
}
#pragma mark - Search Delegat
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    NSMutableArray *filtreadArray = [NSMutableArray array];
    if (![searchString isEqualToString:@""]) {
        for (NSString *key in self.contactsBySections.allKeys) {
            for (POOPhoneBookContact *contact in [self.contactsBySections objectForKey:key]) {
                if ([contact.name localizedCaseInsensitiveContainsString:searchString] || [contact.secondName localizedCaseInsensitiveContainsString:searchString])  {
                    [filtreadArray addObject:contact];
                }
            }
        }
        self.searchContacts = [self getSortedArrayBySection:filtreadArray];
    }

    [self.tableView reloadData];
}

- (void)buildUI {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    self.searchController.searchBar.delegate = self;
    
    self.tableView.tableHeaderView = _searchController.searchBar;
    self.definesPresentationContext = YES;
    
    
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
}

@end
