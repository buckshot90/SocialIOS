//
//  POOVKTableViewCell.h
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 16.02.16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POOVKTableViewCell : UITableViewCell

+ (instancetype)cell;
+ (NSString *)identifier;

- (void)configureWithTitleLabel:(NSString *)titleString  andSubtitleLabel:(NSString *) SubTitleString;
- (void)configureWithName:(NSString *)name  SecondName:(NSString *) secondName;

@end
