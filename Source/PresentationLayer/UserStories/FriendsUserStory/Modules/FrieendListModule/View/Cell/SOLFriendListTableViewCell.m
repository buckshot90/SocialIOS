//
//  SOLFriendListTableViewCell.m
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLFriendListTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

#import "SOLFriendListTableViewCellObject.h"

static CGFloat const kReportListTableViewCellHeight = 60.0f;

@interface SOLFriendListTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UIImageView *userOnline;
@property (weak, nonatomic) IBOutlet UIImageView *userOnlineMobile;

@end

@implementation SOLFriendListTableViewCell

- (BOOL)shouldUpdateCellWithObject:(SOLFriendListTableViewCellObject *)object {
    
    self.userName.text = object.userName;
    [self.userPhoto setImageWithURL:object.userPhoto placeholderImage:nil];
    self.userOnline.hidden = !object.userOnline;
    self.userOnlineMobile.hidden = !object.userOnlineMobile;
//    NSLog(@"user: %@", object);
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    return kReportListTableViewCellHeight;
}

@end
