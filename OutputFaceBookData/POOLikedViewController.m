//
//  POOLikedViewController.m
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 11.04.16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "POOLikedViewController.h"
#import "StringLocalizer.h"

static NSString *MyIdentifier = @"LikedCellIdentifier";

@interface POOLikedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *someArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation POOLikedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildHeader];
    self.someArray = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - TableView delegat and datasource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.someArray.count;
    }

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    if ((self.someArray.count - 1) == indexPath.row ) {
        cell.backgroundColor = [[self class] colorWithPatternImage];
        cell.accessoryView = [[UIImageView alloc]initWithImage:
                              [UIImage imageNamed:@"DarkArrow"]];
        cell.textLabel.text = [@"invaiteFriends" localized];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"Test String";
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UILabel *lable = [[UILabel alloc] init];
    lable.numberOfLines = 0;
    lable.lineBreakMode = NSLineBreakByWordWrapping;
    lable.text = [@"FooterTitle" localized];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor colorWithRed:100.0f/255.0f green:109.0f/255.0f blue:122.0f/255.0f alpha:1.0f];
    lable.font  = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20];
    [lable setBackgroundColor:[[self class] colorWithPatternImage]];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, lable.frame.size.height - 2.0, tableView.frame.size.width, 2)];
    
    lineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"SepparationLine"]];
    [lable addSubview:lineView];
    
    return lable;
}

+ (UIColor *)colorWithPatternImage {
    return [UIColor colorWithPatternImage:[UIImage imageNamed: @"Background"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 140;
}

#pragma mark - UI
- (void)buildHeader {
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"Header"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.topItem.title = [@"Liked" localized];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self creatLeftHeaderButton];
    [self creatRightHeaderButton];
    
}

- (void)creatLeftHeaderButton {
    UIImage *headerButtonImg = [UIImage imageNamed:@"TopButton"];
    
    UIButton *edit = [UIButton buttonWithType:UIButtonTypeCustom];
    edit.bounds = CGRectMake( 0, 0, headerButtonImg.size.width, headerButtonImg.size.height );
    [edit setBackgroundImage:headerButtonImg forState:UIControlStateNormal];
    [edit setTitle:[@"POOLikedViewController.editButton" localized] forState:UIControlStateNormal];
    edit.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    [edit addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customCancelButton = [[UIBarButtonItem alloc] initWithCustomView:edit];
    self.navigationController.topViewController.navigationItem.leftBarButtonItem = customCancelButton;
}

- (void)edit {
    
}

- (void)creatRightHeaderButton {
    UIImage *headerButtonImg = [UIImage imageNamed:@"AddBackGround"];
    
    UIButton *add = [UIButton buttonWithType:UIButtonTypeCustom];
    add.bounds = CGRectMake( 0, 0, headerButtonImg.size.width, headerButtonImg.size.height );
    [add setBackgroundImage:headerButtonImg forState:UIControlStateNormal];
    [add setImage:[UIImage imageNamed:@"Add"] forState:UIControlStateNormal];
    [add setTitle:@"" forState:UIControlStateNormal];
    add.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    [add addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customCancelButton = [[UIBarButtonItem alloc] initWithCustomView:add];
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = customCancelButton;
}

- (void)add {
    
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
