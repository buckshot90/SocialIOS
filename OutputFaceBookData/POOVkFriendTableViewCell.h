//
//  POOVkFriendTableViewCell.h
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 05.04.16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POOVkFriendTableViewCell : UITableViewCell

- (void)configWithName:(NSString *)name secondName:(NSString *)secondName online:(BOOL)online image:(NSString *)image;

@end
