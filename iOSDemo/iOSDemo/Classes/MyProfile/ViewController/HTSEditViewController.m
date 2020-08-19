//
//  HTSEditViewController.m
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-08-07.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import "HTSEditViewController.h"
#import "HTSEditNameCell.h"
#import "HTSEditIdCell.h"
#import "HTSEditIntroCell.h"
#import "HTSEditAvatarCell.h"
#import "HTSEditSelectInfoCell.h"
#import <Masonry/Masonry.h>


@interface HTSEditViewController ()
@property (strong, nonatomic) UITableView *myTableView;
@end

@implementation HTSEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑资料";
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.backgroundColor = [UIColor grayColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[HTSEditAvatarCell class] forCellReuseIdentifier:@"HTSEditAvatarCell"];
        [tableView registerClass:[HTSEditNameCell class] forCellReuseIdentifier:@"HTSEditNameCell"];
        [tableView registerClass:[HTSEditIdCell class] forCellReuseIdentifier:@"HTSEditIdCell"];
        [tableView registerClass:[HTSEditSelectInfoCell class] forCellReuseIdentifier:@"HTSEditSelectInfoCell"];
        [tableView registerClass:[HTSEditIntroCell class] forCellReuseIdentifier:@"HTSEditIntroCell"];
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView;
    });
    // Do any additional setup after loading the view.
}


-(void)setupUIComponents {
    
}

-(void)setupHeader {
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger row;
    switch (section) {
        case 0:
            row = 1;
            break;
        case 1:
            row = 1;
            break;
        case 4:
            row = 2;
            break;
        default:
            row = 1;
            break;
    }
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HTSEditAvatarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTSEditAvatarCell" forIndexPath:indexPath];
        [cell setTitleStr:@"头像" valueStr:@"placeholder"];
        //cell.curUser = _curUser;
        //[tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kPaddingLeftWidth];
        return cell;
    }else if (indexPath.section == 2){
        HTSEditNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTSEditNameCell" forIndexPath:indexPath];
        [cell setTitleStr:@"昵称" valueStr:@"placeholder"];
        //[tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kPaddingLeftWidth];
        return cell;
    }else if (indexPath.section == 3){
        HTSEditIdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTSEditIdCell" forIndexPath:indexPath];
        [cell setTitleStr:@"火山号" valueStr:@"placeholder"];
        //[tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kPaddingLeftWidth];
        return cell;
    }
    else if (indexPath.section == 4){
        HTSEditSelectInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTSEditSelectInfoCell" forIndexPath:indexPath];
        //[tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kPaddingLeftWidth];
        switch (indexPath.row) {
            case 1:
                [cell setTitleStr:@"性别" valueStr:@"placeholder"];
                break;
            case 2:
                [cell setTitleStr:@"生日" valueStr:@"placeholder"];
                break;
        }
        return cell;
    }
    else{
        HTSEditIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTSEditIntroCell" forIndexPath:indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight;
    if (indexPath.section == 0) {
        cellHeight = [HTSEditAvatarCell cellHeight];
    }else if (indexPath.section == 2){
        cellHeight = [HTSEditAvatarCell cellHeight];
    }else{
        cellHeight = [HTSEditIdCell cellHeight];
    }
    return cellHeight;
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
