//
//  TSOptimizeTableViewController.m
//  TSDemo_Demo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "TSOptimizeTableViewController.h"
#import "TSOptimizeImageUtil.h"

@interface TSOptimizeTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonnull, nonatomic, strong) NSMutableArray<NSString *> *imageNameArray;

@end

@implementation TSOptimizeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"模拟卡顿FPS", nil);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        if #available(iOS 11.0, *) {
//            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
//            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
//        } else {
//            // Fallback on earlier versions
//            // topLayoutGuide\bottomLayoutGuide iOS11已经被弃用
//            make.top.equalTo(topLayoutGuide.snp.bottom).offset(10)
//            make.bottom.equalTo(bottomLayoutGuide.snp.top).offset(-10)
//        }
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(10);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-10);
        } else {
            // Fallback on earlier versions
            // topLayoutGuide\bottomLayoutGuide iOS11已经被弃用
            make.top.equalTo(self.mas_topLayoutGuideBottom).offset(10);
            make.bottom.equalTo(self.mas_bottomLayoutGuideTop).offset(-10);
        }
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.centerX.mas_equalTo(self.view);
    }];
    
    
    self.imageNameArray = [TSOptimizeImageUtil cjts_localImageNames];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.imageNameArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *indexTitle = [NSString stringWithFormat:@"section:%zd", section];
    return indexTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    [TSOptimizeImageUtil performExpensiveOperation];
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    NSString *title = [NSString stringWithFormat:@"%zd", indexPath.row];
    cell.textLabel.text = title;
    
    NSString *imageName = [self.imageNameArray objectAtIndex:indexPath.row];
    cell.imageView.image = [TSOptimizeImageUtil cqdemokit_xcassetImageNamed:imageName withCache:NO];
    
    
    //set image shadow
    cell.imageView.layer.shadowOffset = CGSizeMake(0, 5);
    cell.imageView.layer.shadowOpacity = 0.75;
    cell.clipsToBounds = YES;
    //set text shadow
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.layer.shadowOffset = CGSizeMake(0, 2);
    cell.textLabel.layer.shadowOpacity = 0.5;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"点击了%zd-%zd", indexPath.section, indexPath.row);
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
