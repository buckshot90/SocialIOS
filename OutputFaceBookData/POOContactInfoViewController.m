//
//  POOContactInfoViewController.m
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 25.01.16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import "POOContactInfoViewController.h"
#import "Consts.h"
#import "StringLocalizer.h"

@interface POOContactInfoViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSDictionary *phones;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation POOContactInfoViewController

- (POOContactInfoViewController *)initWithName:(NSString *)name lastName:(NSString *)lastName phones:(NSDictionary *)phones {
    self.name = name;
    self.lastName = lastName;
    self.phones = phones;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildHeader];
    [self creatUI];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)buildHeader {
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed: @"Background"]]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"Header_black"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    
    UIImage *headerButtonImg = [UIImage imageNamed:@"Back_button"];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.bounds = CGRectMake( 0, 0, headerButtonImg.size.width, headerButtonImg.size.height );
    [cancelButton setBackgroundImage:headerButtonImg forState:UIControlStateNormal];
    [cancelButton setTitle:[@"backButtonTitle" localized] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
    [cancelButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customCancelButton = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    self.navigationController.topViewController.navigationItem.leftBarButtonItem = customCancelButton;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.phones.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    NSString *curentKey = [_phones.allKeys objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ : %@",curentKey ,[_phones objectForKey:curentKey]];
    
    [self creatRoundCornersByIndexPath:indexPath forCell:cell amountOfCell:self.phones.allKeys.count];
    
    return cell;
}

- (void) creatRoundCornersByIndexPath:(NSIndexPath *)indexPath forCell:(UITableViewCell *)cell amountOfCell:(NSInteger)amount {
    if (indexPath.row == 0) {
        if (amount > 1) {
            [self roundCorners:UIRectCornerTopLeft | UIRectCornerTopRight radius:10.0f textField:cell];
        } else {
            [self roundCorners:UIRectCornerAllCorners radius:10.0f textField:cell];
        }
    } else if (indexPath.row == self.phones.allKeys.count - 1) {
        [self roundCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight radius:10.0f textField:cell];
    } else {
        [self roundCorners:UIRectCornerAllCorners radius:0 textField:cell];
    }
    [cell setBackgroundColor:[UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.0f]];
    [self creatSeparatorForCell:cell atIndexPaht:indexPath];
}

- (void)creatSeparatorForCell:(UITableViewCell *)cell atIndexPaht:(NSIndexPath *)indexPath {
    UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 1)];
    separatorLineView.backgroundColor = [UIColor colorWithRed:166.0f/255.0f green:172.0f/255.0f blue:177.0f/255.0f alpha:1.0f];
    [cell.contentView addSubview:separatorLineView];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *curentKey = [_phones.allKeys objectAtIndex:indexPath.row];
    [self ShowSMS:[_phones objectForKey:curentKey]];
}

- (void) ShowSMS:(NSString *) phone {
    
    if(![MFMessageComposeViewController canSendText]) {
        
        NSLog(@"device doesn't support SMS!");
        return;
    }
    
    NSArray *recipents = @[phone];
    NSString *message = [NSString stringWithFormat:@"Some Text"];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}

#pragma mark - UI
- (void)creatUI {
    [self setTitle:[NSString stringWithFormat:@"%@ %@",self.name, self.lastName]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:18.0f],
        NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:[UIImage imageNamed:@"Placeholder"]];
    imageView.layer.cornerRadius = 10.0f;
    
    UILabel *nameLable = [[UILabel alloc] init];
    [nameLable setText:[NSString stringWithFormat:@"%@ %@",_name, _lastName]];
    [nameLable setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:24.0f]];
    [nameLable setTextColor:[UIColor darkGrayColor]];
    
    self.tableView = [[UITableView alloc] init];
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]]];
    self.tableView.scrollEnabled = NO;
    CGFloat height = 44;
    height *= [self.phones allKeys].count;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIButton *addToFavorites = [UIButton buttonWithType:UIButtonTypeSystem];
    [addToFavorites setTitle:[@"addToFavorites" localized] forState:UIControlStateNormal];
    [addToFavorites setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]]];
    [addToFavorites setBackgroundImage:[UIImage imageNamed:@"Large_button"] forState:UIControlStateNormal];
    [addToFavorites addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchDown];
    
    UIButton *sendMessage = [UIButton buttonWithType:UIButtonTypeSystem];
    [sendMessage setTitle:[@"sendMessageText" localized] forState:UIControlStateNormal];
    [sendMessage setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]]];
    [sendMessage setBackgroundImage:[UIImage imageNamed:@"Large_button"] forState:UIControlStateNormal];
    [sendMessage addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:imageView];
    [self.view addSubview:nameLable];
    [self.view addSubview:self.tableView];
    [self.view addSubview:addToFavorites];
    [self.view addSubview:sendMessage];
    
    [self creatConstraints:imageView nameLable:nameLable sendMessegeButton:sendMessage tableView:self.tableView tableViewHieght:height addToFavorites:addToFavorites];
}

- (void) sendMessage {
    if(![MFMessageComposeViewController canSendText]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"device doesn't support SMS!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:NO completion:NULL];
    }
}

- (void) messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to send SMS!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:ok];
    
    switch (result) {
        case MessageComposeResultCancelled:
            break;
           
        case MessageComposeResultSent:
            break;
            
        case MessageComposeResultFailed:
            [self presentViewController:alertController animated:YES completion:NULL];
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Constrains
- (void)creatConstraints:(UIImageView *)imageView nameLable:(UILabel *)nameLable sendMessegeButton:(UIButton *)sendMessegeButton tableView:(UITableView *)tableView tableViewHieght:(CGFloat)tableViewHieght addToFavorites:(UIButton *)addToFavorites {
    if (self.view.constraints.count == 0) {
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        nameLable.translatesAutoresizingMaskIntoConstraints = NO;
        sendMessegeButton.translatesAutoresizingMaskIntoConstraints = NO;
        tableView.translatesAutoresizingMaskIntoConstraints = NO;
        addToFavorites.translatesAutoresizingMaskIntoConstraints = NO;
        // imageView Constraint
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:kConstsIndent]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:kConstsIndent]];
        // lable Constraint
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:nameLable attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:kConstsIndent + kConstsIndent]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:nameLable attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeTrailing multiplier:1 constant:kConstsIndent]];
        // sendMessegeButton Constraint
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:sendMessegeButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:kConstsIndent * 6]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:sendMessegeButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:kConstsIndent]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:sendMessegeButton attribute:NSLayoutAttributeTrailing multiplier:1 constant:kConstsIndent]];
        // tableView Contstarins
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:sendMessegeButton attribute:NSLayoutAttributeBottom multiplier:1 constant:kConstsIndent]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:tableViewHieght]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:kConstsIndent]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:tableView attribute:NSLayoutAttributeTrailing multiplier:1 constant:kConstsIndent]];
        // addToFavorites
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:addToFavorites attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:tableView attribute:NSLayoutAttributeBottom multiplier:1 constant:kConstsIndent]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view  attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:addToFavorites attribute:NSLayoutAttributeBottom multiplier:1 constant:kConstsIndent]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:addToFavorites attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:kConstsIndent]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:addToFavorites attribute:NSLayoutAttributeTrailing multiplier:1 constant:kConstsIndent]];
    }
}

- (void)roundCorners:(UIRectCorner)corners radius:(CGFloat)radius textField:(UITableViewCell *)textField {
    CGRect bounds = CGRectMake(0, 0, self.tableView.frame.size.width, textField.frame.size.height);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    
    textField.layer.mask = maskLayer;
    
    CAShapeLayer*   frameLayer = [CAShapeLayer layer];
    frameLayer.frame = bounds;
    frameLayer.path = maskPath.CGPath;
    frameLayer.strokeColor = [UIColor colorWithRed:166.0f/255.0f green:172.0f/255.0f blue:177.0f/255.0f alpha:1.0f].CGColor;
    frameLayer.fillColor = nil;
    
    [textField.layer addSublayer:frameLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
