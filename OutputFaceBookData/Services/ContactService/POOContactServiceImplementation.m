//
//  POOContactServiceImplementation.m
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 13.04.16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "POOContactServiceImplementation.h"
#import "POOPhoneBookContact.h"
#import <Contacts/Contacts.h>

@implementation POOContactServiceImplementation

-(NSArray *)getAllContacts {
    if ([CNContactStore class]) {
        CNContactStore *addresBook = [[CNContactStore alloc] init];
        
        NSArray *keysToFetch = @[CNContactEmailAddressesKey,
                                 CNContactFamilyNameKey,
                                 CNContactGivenNameKey,
                                 CNContactPhoneNumbersKey,
                                 CNContactPostalAddressesKey,
                                 CNContactMiddleNameKey,
                                 CNContactPreviousFamilyNameKey];
        CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
        
        NSMutableArray *groupOfContacts = [NSMutableArray array];
        NSMutableArray *contactPhones = [NSMutableArray array];
        [addresBook enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            [groupOfContacts addObject:contact];
        }];
        
        for (CNContact *contact in groupOfContacts) {
            POOPhoneBookContact *phoneContact = [[POOPhoneBookContact alloc] initWithContact:contact];
            [contactPhones addObject:phoneContact];
        }
        
        return contactPhones;
    }
    
    return nil;
}

@end
