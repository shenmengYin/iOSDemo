//
//  HTSEditViewController.m
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-08-07.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//


#import "HTSEditViewController.h"
#import "HTSEditIntroCell.h"
#import "HTSEditAvatarCell.h"
#import "HTSEditSelectInfoCell.h"
#import "HTSEditAvatarView.h"
#import "HTSSelectImageManager.h"
#import "HTSEditViewModel.h"
#import "HTSProfileEditTextCell.h"
#import "HTSProfileEditTextCell.h"
#import "HTSDatePickerView.h"

#import <Masonry/Masonry.h>




@interface HTSEditViewController () <HTSSelectImageManagerDelegate, HTSProfileEditTextCellDelegate, HTSEditSelectInfoCellDelegate, HTSEditAvatarViewDelegate, HTSDatePickerViewDelegate>
@property (nonatomic, strong) HTSEditViewModel *viewModel;
@property (nonatomic, strong) HTSEditSelectInfoCell *currentCell;
@property (nonatomic, strong) NSMutableArray *cellArray;
@property (nonatomic, strong) HTSEditAvatarView *editAvatarView;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UIAlertController *actionController;
@property (nonatomic, strong) HTSSelectImageManager *imageManager;
@property (nonatomic, strong) HTSDatePickerView *datePickerView;

@end

@implementation HTSEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑资料";
    self.viewModel = [[HTSEditViewModel alloc] init];
    //[self.viewModel writeToLocalDataWithKey:@"昵称" value:@"test"];
    [self configNavBar];
    [self setupUIComponents];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


-(void)setupUIComponents {
    [self.view addSubview:self.editAvatarView];
    [self.view addSubview:self.myTableView];
}

-(void)configNavBar{
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"保存"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(saveEdit)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (UITableView *)myTableView{
    if(!_myTableView){
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/3, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
        _myTableView.scrollEnabled = YES;
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _myTableView.separatorColor = [UIColor grayColor];
        [_myTableView registerClass:[HTSProfileEditTextCell class] forCellReuseIdentifier:@"HTSProfileEditTextCell"];
        [_myTableView registerClass:[HTSEditSelectInfoCell class] forCellReuseIdentifier:@"HTSEditSelectInfoCell"];
        [_myTableView registerClass:[HTSEditIntroCell class] forCellReuseIdentifier:@"HTSEditIntroCell"];
        _myTableView.estimatedRowHeight = 0;
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
    }
    return _myTableView;
}

- (HTSEditAvatarView *)editAvatarView{
    if(!_editAvatarView){
        _editAvatarView = [[HTSEditAvatarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 3)];
        [_editAvatarView setLabelStr:@"点击更换头像"];
        if([self.viewModel readFromLocalData:@"avatar"]){
            NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:[self.viewModel readFromLocalData:@"avatar"] options:NSDataBase64EncodingEndLineWithLineFeed];
            UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
            [_editAvatarView setAvatarImage:decodedImage];
        }else{
            [_editAvatarView setAvatarImage:[UIImage imageNamed:@"defaultProfilePicture"]];
        }
        _editAvatarView.delegate = self;
    }
    return _editAvatarView;
}

- (NSMutableArray *)cellArray{
    _cellArray = [[NSMutableArray alloc] init];
    for(NSString *cellTitle in [self.viewModel textEditItemArray]){
        HTSProfileEditTextCell *cell = [[HTSProfileEditTextCell alloc] init];
        [cell setTitleStr:cellTitle valueStr:[self.viewModel readFromLocalData:cellTitle]];
        cell.delegate = self;
        [_cellArray addObject:cell];
    }
    for(NSString *cellTitle in [self.viewModel pickerItemArray]){
        HTSEditSelectInfoCell *cell = [[HTSEditSelectInfoCell alloc] init];
        [cell setTitleStr:cellTitle valueStr:[self.viewModel readFromLocalData:cellTitle]];
        cell.delegate = self;
        [_cellArray addObject:cell];
    }
    return _cellArray;
}

- (HTSDatePickerView *)datePickerView
{
    if (!_datePickerView) {
        CGFloat startY = self.view.bounds.size.height - 260;
        CGRect frame = CGRectMake(0, startY, self.view.bounds.size.width, 260);
        _datePickerView = [[HTSDatePickerView alloc] initWithFrame:frame];
        UIColor *color = [UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0];
        _datePickerView.backgroundColor = color;
    }
    return _datePickerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger row = 1;
    switch (section) {
        case 0:
            row = [self.cellArray count];
            break;
    }
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        return [self.cellArray objectAtIndex:indexPath.row];
//        NSArray *textEditCellArray = [self.viewModel textEditItemArray];
//        NSString *cellTitle = [textEditCellArray objectAtIndex:indexPath.row];
//        HTSProfileEditTextCell *textCell = [tableView dequeueReusableCellWithIdentifier:@"HTSProfileEditTextCell"];
//        [textCell setTitleStr:cellTitle valueStr:@""];
//        return textCell;
//        switch (indexPath.row){
//            case 0:
//                {
//                HTSProfileEditTextCell *cell;
//                cell = [tableView dequeueReusableCellWithIdentifier:@"HTSProfileEditTextCell" forIndexPath:indexPath];
//                    [cell setTitleStr:@"昵称" valueStr:[self.viewModel readFromLocalData:@"name"]];
//                return cell;
//                }
//            case 1:
//            {
//                HTSProfileEditTextCell *cell;
//                cell = [tableView dequeueReusableCellWithIdentifier:@"HTSProfileEditTextCell" forIndexPath:indexPath];
//                [cell setTitleStr:@"火山号" valueStr:[self.viewModel readFromLocalData:@"user_id"]];
//                cell.delegate = self;
//                return cell;
//            }
//            case 2:
//            {
//                HTSEditSelectInfoCell *cell;
//                cell = [tableView dequeueReusableCellWithIdentifier:@"HTSEditSelectInfoCell" forIndexPath:indexPath];
//                [cell setTitleStr:@"性别" valueStr:[self.viewModel readFromLocalData:@"gender"]];
//                cell.delegate = self;
//                return cell;
//                break;
//            }
//            case 3:
//            {
//                HTSEditSelectInfoCell *cell;
//                cell = [tableView dequeueReusableCellWithIdentifier:@"HTSEditSelectInfoCell" forIndexPath:indexPath];
//                [cell setTitleStr:@"生日" valueStr:[self.viewModel readFromLocalData:@"birthday"]];
//                return cell;
//                break;
//            }
//            default:
//            {
//                HTSProfileEditTextCell *cell;
//                cell = [tableView dequeueReusableCellWithIdentifier:@"HTSProfileEditTextCell" forIndexPath:indexPath];
//                [cell setTitleStr:@"昵称" valueStr:[self.viewModel readFromLocalData:@"name"]];
//                //[tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kPaddingLeftWidth];
//                return cell;
//            }
//        }
    }
    else{//} if(indexPath.section == 1){
        HTSEditIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTSEditIntroCell" forIndexPath:indexPath];
        [cell setViewText:[self.viewModel readFromLocalData:@"intro"]];
        NSLog(@"section: %ld, row:%ld", indexPath.section, indexPath.row);
        return cell;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[_viewModel cellHeight:indexPath.section] floatValue];
}


- (void)closeBtnTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveEdit{
    HTSProfileEditTextCell *nameCell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    HTSProfileEditTextCell *editIdCell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    HTSEditSelectInfoCell *genderCell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    HTSEditSelectInfoCell *birthdayCell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
    HTSEditIntroCell *introCell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    UIImage *originImage = [_editAvatarView avatarImageView].image;
    NSData *data = UIImageJPEGRepresentation(originImage, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    [self.viewModel writeToLocalDataWithKey:@"昵称" value:nameCell.valueTextField.text];
    [self.viewModel writeToLocalDataWithKey:@"火山号" value:editIdCell.valueTextField.text];
    [self.viewModel writeToLocalDataWithKey:@"性别" value:genderCell.genderLabel.text];
    [self.viewModel writeToLocalDataWithKey:@"生日" value:birthdayCell.genderLabel.text];
    [self.viewModel writeToLocalDataWithKey:@"intro" value:introCell.introTextView.text];
    [self.viewModel writeToLocalDataWithKey:@"avatar" value:encodedImageStr];
    [self closeBtnTapped];
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
    [_editAvatarView setAvatarImage:image];
    UIImageWriteToSavedPhotosAlbum(image, self, nil, NULL);
}

//HTSDatePickerViewDelegate
//- (void)cancelChangeBirthday{
//    [self.datePickerView removeFromSuperview];
//}
//
//- (void)changeBirthday{
//    [self.viewModel writeToLocalDataWithKey: value:(nonnull NSString *)];
//}


//HTSProfileEditTextCellDelegate

- (void)editCell: (HTSProfileEditTextCell *)cell copyUserId:(NSString *)userId{
    [[UIPasteboard generalPasteboard] setString: userId ?: @""];
    NSString *message = @"火山号已复制到剪贴板";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message  preferredStyle:UIAlertControllerStyleActionSheet];
    [self presentViewController:alert animated:YES completion:nil];
    int duration = 1; // duration in seconds
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
}


//HTSSelectInfoCellDelegate
- (void)selectInfoCell:(HTSEditSelectInfoCell *)cell changeGender:(NSString *)gender{
    _currentCell = cell;
    _actionController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *pickMaleAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.viewModel changeGender:@"男"];
        cell.genderLabel.text = @"男";
    }];
    UIAlertAction *pickFemaleAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.viewModel changeGender:@"女"];
        cell.genderLabel.text = @"女";
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [_actionController addAction:pickMaleAction];
    [_actionController addAction:pickFemaleAction];
    [_actionController addAction:cancelAction];
    [self presentViewController:_actionController animated:YES completion:nil];
}

- (void)selectInfoCell:(HTSEditSelectInfoCell *)cell changeBirthday:(NSString *)birthday{
    _currentCell = cell;
    [self.view bringSubviewToFront:self.datePickerView];
}

//EditAvatarViewDelegate
- (void)tapAvatarLabel:(UIImageView *)avatarImageView{
    _actionController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *photographAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self photograph];
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectFromAlbum];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [_actionController addAction:photographAction];
    [_actionController addAction:albumAction];
    [_actionController addAction:cancelAction];
    [self presentViewController:_actionController animated:YES completion:nil];
}


@end
