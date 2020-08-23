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
#import "HTSSelectImageManager.h"



@interface HTSEditViewController () <HTSSelectImageManagerDelegate, HTSEditIdCellDelegate, HTSEditSelectInfoCellDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) UIAlertController *actionController;
@property (nonatomic,strong) HTSSelectImageManager *imageManager;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *genderView;
@property (nonatomic, strong) UIPickerView *genderPicker;
@property (nonatomic, assign) NSInteger genderType;
@property (nonatomic, strong) UIToolbar *genderToolBar;

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
    [self configNavBar];
    
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
    
}

-(void)configNavBar{
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"保存"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(saveEdit)];
    self.navigationItem.rightBarButtonItem = saveButton;
    //[saveButton release];
}

-(void)setupHeader {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
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
    NSArray *sandBoxPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [sandBoxPath objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"user.plist"];
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    if (indexPath.section == 0) {
        HTSEditAvatarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTSEditAvatarCell" forIndexPath:indexPath];
        if(dataDic[@"avatar"]){
            NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:dataDic[@"avatar"] options:NSDataBase64EncodingEndLineWithLineFeed];
            UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
            [cell setAvatarImage:decodedImage];
        }
        else{
            [cell setAvatarImage:[UIImage imageNamed:@"defaultProfilePicture"]];
        }
        [cell setTitleStr:@"点击更换头像"];
        //cell.curUser = _curUser;
        //[tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kPaddingLeftWidth];
        return cell;
    }else if (indexPath.section == 1){
        switch (indexPath.row){
            case 0:
                {
                HTSEditNameCell *cell;
                cell = [tableView dequeueReusableCellWithIdentifier:@"HTSEditNameCell" forIndexPath:indexPath];
                [cell setTitleStr:@"昵称" valueStr:dataDic[@"name"]];
                //[tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kPaddingLeftWidth];
                return cell;
                }
            case 1:
            {
                HTSEditIdCell *cell;
                cell = [tableView dequeueReusableCellWithIdentifier:@"HTSEditIdCell" forIndexPath:indexPath];
                [cell setTitleStr:@"火山号" valueStr:dataDic[@"user_id"]];
                cell.delegate = self;
                //[tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kPaddingLeftWidth];
                return cell;
            }
            case 2:
            {
                HTSEditSelectInfoCell *cell;
                cell = [tableView dequeueReusableCellWithIdentifier:@"HTSEditSelectInfoCell" forIndexPath:indexPath];
                [cell setTitleStr:@"性别" valueStr:dataDic[@"gender"]];
                cell.delegate = self;
                return cell;
                break;
            }
            case 3:
            {
                HTSEditSelectInfoCell *cell;
                cell = [tableView dequeueReusableCellWithIdentifier:@"HTSEditSelectInfoCell" forIndexPath:indexPath];
                [cell setTitleStr:@"生日" valueStr:dataDic[@"birthday"]];
                return cell;
                break;
            }
            default:
            {
                HTSEditNameCell *cell;
                cell = [tableView dequeueReusableCellWithIdentifier:@"HTSEditNameCell" forIndexPath:indexPath];
                [cell setTitleStr:@"昵称" valueStr:dataDic[@"name"]];
                //[tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kPaddingLeftWidth];
                return cell;
            }
        }
    }
    else if(indexPath.section == 2 && indexPath.row == 0){
        HTSEditIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTSEditIntroCell" forIndexPath:indexPath];
        [cell setViewText:dataDic[@"intro"]];
        NSLog(@"section: %ld, row:%ld", indexPath.section, indexPath.row);
        return cell;
    }
    HTSEditNameCell *cell;
    return cell;
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

- (void)closeBtnTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveEdit{
    NSArray *sandBoxPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [sandBoxPath objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"user.plist"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    HTSEditNameCell *nameCell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    HTSEditIdCell *editIdCell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    HTSEditSelectInfoCell *genderCell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    //HTSEditSelectInfoCell *birthdayCell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
    HTSEditIntroCell *introCell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    HTSEditAvatarCell *avatarCell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UIImage *originImage = avatarCell.avatar.image;
    NSData *data = UIImageJPEGRepresentation(originImage, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    [dic setObject:nameCell.valueTextField.text forKey:@"name"];
    [dic setObject:editIdCell.valueTextField.text forKey:@"user_id"];
    [dic setObject:genderCell.genderLabel.text forKey:@"gender"];
    //[dic setObject:birthdayCell. forKey:@"birthday"];
    [dic setObject:encodedImageStr forKey:@"avatar"];
    [dic setObject:introCell.introTextView.text forKey:@"intro"];
    [dic writeToFile:plistPath atomically:YES];
    [self.navigationController popViewControllerAnimated:YES];
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


- (UIPickerView *) pickerGenderView
{
    if (!_genderPicker) {
        _genderPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, self.view.window.bounds.size.width, 156)];
        CALayer *viewLayer = _genderPicker.layer;
        [viewLayer setFrame:CGRectMake(0, 44, self.view.window.bounds.size.width, 156)];
        //self.selectGender = _genderType;
        _genderPicker.delegate = self;
        _genderPicker.dataSource = self;
    }
    
    return _genderPicker;
}

- (UIView *) genderView
{
    if (!_genderView) {
        CGFloat startY = self.view.window.bounds.size.height - 200;
        CGRect frame = CGRectMake(0, startY, self.view.window.bounds.size.width, 200);
        _genderView = [[UIView alloc] initWithFrame:frame];
        UIColor *color = [UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0];
        _genderView.backgroundColor = color;
        [_genderView addSubview:self.pickerGenderView];
        [_genderView addSubview:self.genderToolBar];
        [self.view addSubview:_genderView];
    }
    
    return _genderView;
}

- (UIToolbar *) genderToolBar
{
    if (nil == _genderToolBar) {
        _genderToolBar = [[UIToolbar alloc] init];
        UIColor *color = [UIColor colorWithRed:193.0/255.0 green:193.0/255.0 blue:193.0/255.0 alpha:1.0];
        _genderToolBar.backgroundColor = color;
        _genderToolBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44);
        
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelChangeGender)];
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(changeGenderTool)];
        _genderToolBar.items = @[cancel, flexSpace, done];
    }
    
    return _genderToolBar;
}

-(void) cancelChangeGender{
    [self.maskView removeFromSuperview];
    [self.genderView removeFromSuperview];
    [self.genderPicker removeFromSuperview];
}


//HTSEditIdCellDelegate

-(void) editIdCell: (HTSEditIdCell *)cell copyUserId:(NSString *)userId{
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
-(void) selectInfoCell:(HTSEditSelectInfoCell *)cell changeGender:(NSString *)gender{
        self.maskView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-200);
        self.maskView.alpha = 0.5;
        
        [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
            //[self __showGenderPick:YES];
            //UIWindow *win = [[UIWindow alloc] init];
            [self.view addSubview:self.maskView];
            [self.view bringSubviewToFront:self.genderView];
        } completion:
         ^(BOOL finished) {
            NSInteger row;
            switch (self.genderType) {
                case 0:
                    row = 0;
                    break;

                case 1:
                    row = 1;
                    break;

                case 2:
                    row = 2;
                    break;

                default:
                    row = 0;
                    break;
            }
            [self.genderPicker selectRow:row inComponent:0 animated:YES];
        }
         ];
}

-(void) selectInfoCell:(HTSEditSelectInfoCell *)cell changeBirthday:(NSString *)birthday{
    
}





//UIPickViewDelegate

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (row) {
        case 0:
            self.genderType = 0;
            break;
        case 1:
            self.genderType = 1;
            break;
        case 2:
            self.genderType = 2;
            break;
        default:
            break;
    }
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = nil;
    if (0 == component) {
        switch (row) {
            case 0:
                title = NSLocalizedString(@"男", nil);
                break;
            case 1:
                title = NSLocalizedString(@"女", nil);
                break;
            case 2:
                title = NSLocalizedString(@"秘密", nil);
                break;
            default:
                break;
        }
    }
    return title;
}

- (CGFloat) pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44.0f;
}

//Pickview datasource
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}


@end
