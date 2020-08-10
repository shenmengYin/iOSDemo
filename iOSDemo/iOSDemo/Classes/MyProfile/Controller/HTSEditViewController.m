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
//#import "ActionSheetStringPicker.h"
//#import "ActionSheetDatePicker.h"
#import "HTSSelectImageManager.h"


@interface HTSEditViewController () <HTSSelectImageManagerDelegate>
@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) UIAlertController *actionController;
@property (nonatomic,strong) HTSSelectImageManager *imageManager;
@end

@implementation HTSEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑资料";
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.backgroundColor = [self colorWithHexString:@"#F0F0F0"];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.scrollEnabled = NO;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 75.0;
    }
    else{
        return 0.01;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *defaultHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.01)];
    if(section == 0){
        UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        headerV.backgroundColor = [UIColor whiteColor];
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [closeBtn setTitle:@"返回" forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnTapped) forControlEvents:UIControlEventTouchUpInside];

            //closeBtn.titleLabel.textColor = [UIColor blackColor];
            //closeBtn.titleLabel.text = @"返回";
        //    [closeBtn bk_addEventHandler:^(id sender) {
        //        weakSelf.isHeaderClosed = YES;
        //        [weakSelf configHeader];
        //    } forControlEvents:UIControlEventTouchUpInside];
        [headerV addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerV.mas_left).offset(20);
            make.bottom.equalTo(headerV.mas_bottom).inset(5);
        }];
        

        self.myTableView.tableHeaderView = headerV;
        return headerV;
    }
    return defaultHeader;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger row;
    switch (section) {
        case 0:
            row = 1;
            break;
        case 1:
            row = 4;
            break;
        case 2:
            row = 1;
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
        [cell setTitleStr:@"点击更换头像"];
        //cell.curUser = _curUser;
        //[tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kPaddingLeftWidth];
        return cell;
    }else if (indexPath.section == 1){
        HTSEditNameCell *cell;
        switch (indexPath.row){
            case 0:
                cell = [tableView dequeueReusableCellWithIdentifier:@"HTSEditNameCell" forIndexPath:indexPath];
                [cell setTitleStr:@"昵称" valueStr:@"placeholder"];
                //[tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kPaddingLeftWidth];
                return cell;
            case 1:
                cell = [tableView dequeueReusableCellWithIdentifier:@"HTSEditIdCell" forIndexPath:indexPath];
                [cell setTitleStr:@"火山号" valueStr:@"placeholder"];
                //[tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kPaddingLeftWidth];
                return cell;
            case 2:
                cell = [tableView dequeueReusableCellWithIdentifier:@"HTSEditSelectInfoCell" forIndexPath:indexPath];
                [cell setTitleStr:@"性别" valueStr:@"placeholder"];
                break;
            case 3:
                cell = [tableView dequeueReusableCellWithIdentifier:@"HTSEditSelectInfoCell" forIndexPath:indexPath];
                [cell setTitleStr:@"生日" valueStr:@"placeholder"];
                break;
            default:
                cell = [tableView dequeueReusableCellWithIdentifier:@"HTSEditNameCell" forIndexPath:indexPath];
                [cell setTitleStr:@"昵称" valueStr:@"placeholder"];
                //[tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kPaddingLeftWidth];
                return cell;
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    __weak typeof(self) weakSelf = self;
    switch (indexPath.section) {
        case 0:{
            _actionController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *photographAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //相机
                [self photograph];
            }];
            UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //相册
                [self selectFromAlbum];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [_actionController addAction:photographAction];
            [_actionController addAction:albumAction];
            [_actionController addAction:cancelAction];
            [self presentViewController:_actionController animated:YES completion:nil];
            
            break; }
//        case 1:{
//            switch (indexPath.row) {
//                case 0:{
//                    //学历
//                    NSArray *list = [User degreeList];
//                    NSNumber *index = @(MIN(list.count, MAX(0, _curUser.degree.integerValue - 1)));
//                    [ActionSheetStringPicker showPickerWithTitle:nil rows:@[list] initialSelection:@[index] doneBlock:^(ActionSheetStringPicker *picker, NSArray *selectedIndex, NSArray *selectedValue) {
//                        NSNumber *preValue = weakSelf.curUser.degree;
//                        weakSelf.curUser.degree = @([selectedIndex.firstObject integerValue] + 1);
//                        [weakSelf.myTableView reloadData];
//                        [[Coding_NetAPIManager sharedManager] request_UpdateUserInfo_WithObj:weakSelf.curUser andBlock:^(id data, NSError *error) {
//                            if (data) {
//                                weakSelf.curUser = data;
//                            }else{
//                                weakSelf.curUser.degree = preValue;
//                            }
//                            [weakSelf.myTableView reloadData];
//                        }];
//                    } cancelBlock:nil origin:self.view];
//                }
//                    break;
//                case 1:{
//                    //学校
//                    SettingTextViewController *vc = [SettingTextViewController settingTextVCWithTitle:@"学校" textValue:_curUser.school  doneBlock:^(NSString *textValue) {
//                        NSString *preValue = weakSelf.curUser.school;
//                        weakSelf.curUser.school = textValue;
//                        [weakSelf.myTableView reloadData];
//                        [[Coding_NetAPIManager sharedManager] request_UpdateUserInfo_WithObj:weakSelf.curUser andBlock:^(id data, NSError *error) {
//                            if (data) {
//                                weakSelf.curUser = data;
//                            }else{
//                                weakSelf.curUser.school = preValue;
//                            }
//                            [weakSelf.myTableView reloadData];
//                        }];
//                    }];
//                    [self.navigationController pushViewController:vc animated:YES];
//                }
//                    break;
//                case 2:{//公司
//                    SettingTextViewController *vc = [SettingTextViewController settingTextVCWithTitle:@"公司" textValue:_curUser.company  doneBlock:^(NSString *textValue) {
//                        NSString *preValue = weakSelf.curUser.company;
//                        weakSelf.curUser.company = textValue;
//                        [weakSelf.myTableView reloadData];
//                        [[Coding_NetAPIManager sharedManager] request_UpdateUserInfo_WithObj:weakSelf.curUser andBlock:^(id data, NSError *error) {
//                            if (data) {
//                                weakSelf.curUser = data;
//                            }else{
//                                weakSelf.curUser.company = preValue;
//                            }
//                            [weakSelf.myTableView reloadData];
//                        }];
//                    }];
//                    [self.navigationController pushViewController:vc animated:YES];
//                }
//                    break;
//                default:{//职位
//                    NSArray *jobNameArray = _curJobManager.jobNameArray;
//                    NSNumber *index = [_curJobManager indexOfJobName:_curUser.job_str];
//                    [ActionSheetStringPicker showPickerWithTitle:nil rows:@[jobNameArray] initialSelection:@[index] doneBlock:^(ActionSheetStringPicker *picker, NSArray *selectedIndex, NSArray *selectedValue) {
//                        NSString *preValue = weakSelf.curUser.job_str;
//                        NSNumber *preValueKey = weakSelf.curUser.job;
//
//                        NSNumber *jobIndex = selectedIndex.firstObject;
//                        NSNumber *job = @(jobIndex.intValue +1);
//                        NSString *job_str = selectedValue.firstObject;
//                        _curUser.job = job;
//                        _curUser.job_str = job_str;
//                        [weakSelf.myTableView reloadData];
//                        [[Coding_NetAPIManager sharedManager] request_UpdateUserInfo_WithObj:weakSelf.curUser andBlock:^(id data, NSError *error) {
//                            if (data) {
//                                weakSelf.curUser = data;
//                            }else{
//                                weakSelf.curUser.job_str = preValue;
//                                weakSelf.curUser.job = preValueKey;
//                            }
//                            [weakSelf.myTableView reloadData];
//                        }];
//                    } cancelBlock:nil origin:self.view];
//                }
//                    break;
//            }
//        }
//            break;
//        case 2:{//开发技能
//            SettingSkillsViewController *vc = [SettingSkillsViewController settingSkillsVCWithDoneBlock:^(NSArray *selectedSkills) {
//                NSArray *preSkills = weakSelf.curUser.skills;
//                weakSelf.curUser.skills = selectedSkills;
//                [weakSelf.myTableView reloadData];
//                [[Coding_NetAPIManager sharedManager] request_UpdateUserInfo_WithObj:weakSelf.curUser andBlock:^(id data, NSError *error) {
//                    if (data) {
//                        weakSelf.curUser = data;
//                    }else{
//                        weakSelf.curUser.skills = preSkills;
//                    }
//                    [weakSelf.myTableView reloadData];
//                }];
//            }];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//        default:{//个性标签
//            NSArray *selectedTags = nil;
//            if (_curUser.tags && _curUser.tags.length > 0) {
//                selectedTags = [_curUser.tags componentsSeparatedByString:@","];
//            }
//            SettingTagsViewController *vc = [SettingTagsViewController settingTagsVCWithAllTags:_curTagsManager.tagArray selectedTags:selectedTags doneBlock:^(NSArray *selectedTags) {
//                NSString *preValue = weakSelf.curUser.tags_str;
//                NSString *preValueKey = weakSelf.curUser.tags;
//
//                NSString *tags = @"", *tags_str = @"";
//                if (selectedTags.count > 0) {
//                    tags = [selectedTags componentsJoinedByString:@","];
//                    tags_str = [weakSelf.curTagsManager getTags_strWithTags:selectedTags];
//                }
//
//                weakSelf.curUser.tags = tags;
//                weakSelf.curUser.tags_str = tags_str;
//                [weakSelf.myTableView reloadData];
//                [[Coding_NetAPIManager sharedManager] request_UpdateUserInfo_WithObj:weakSelf.curUser andBlock:^(id data, NSError *error) {
//                    if (data) {
//                        weakSelf.curUser = data;
//                    }else{
//                        weakSelf.curUser.tags_str = preValue;
//                        weakSelf.curUser.tags = preValueKey;
//                    }
//                    [weakSelf.myTableView reloadData];
//                }];
//            }];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
            break;
    }
}







- (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *noHashString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""]; // remove the #
    NSScanner *scanner = [NSScanner scannerWithString:noHashString];
    [scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]]; // remove + and $

    unsigned hex;
    if (![scanner scanHexInt:&hex]) return nil;
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;

    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

- (IBAction)closeBtnTapped{
    [self dismissViewControllerAnimated:YES completion:nil];
}
    
-(void)selectFromAlbum{
    if (!_imageManager) {
        //初始化并设置代理
        _imageManager = [[HTSSelectImageManager alloc] initWithViewController:self];
        _imageManager.deleagte = self;
    }
    //调用方法进行图片的选择
    [_imageManager selectImageWithAlbum];
}
    
-(void)photograph{
    if (!_imageManager) {
        _imageManager = [[HTSSelectImageManager alloc] initWithViewController:self];
        _imageManager.deleagte = self;
    }
    [_imageManager selectImageWithCamera];
}

-(void)didChooseImage:(UIImage *)image{
    HTSEditAvatarCell *avatarCell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [avatarCell.avatar setImage:image];
    UIImageWriteToSavedPhotosAlbum(image, self, nil, NULL);
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
