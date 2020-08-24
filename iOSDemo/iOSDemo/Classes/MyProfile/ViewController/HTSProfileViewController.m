//
//  ViewController.m
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-07-15.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//
#import "HTSVideoModel.h"
#import "HTSVideoCollectionViewCell.h"
#import "HTSProfileViewController.h"
#import "HTSProfileViewModel.h"
#import "HTSVideoCellViewModel.h"
#import "HTSProfileHeader.h"
#import "UIImageView+WebCache.h"
#import "HTSEditViewController.h"

#define SAFE_AREA_TOP_HEIGHT ((SCREEN_HEIGHT >= 812.0) && [[UIDevice currentDevice].model isEqualToString:@"iPhone"] ? 88 : 64)
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

static int const numOfColumns = 3;
static NSString *const cellIdentifier = @"HTSVideoCollectionViewCell";
static NSString *const headerIdentifier = @"HTSProfileHeader";

@interface HTSProfileViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HTSProfileHeaderDelegate>

@property (nonatomic) HTSProfileViewModel *viewModel;
@property (nonatomic) HTSProfileHeader *profileHeader;
@property (nonatomic) NSArray *cellViewModelArray;
@property (nonatomic, strong) NSMutableArray *videos;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;

@end

@implementation HTSProfileViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_profileHeader reloadUserInfo];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[_collectionView collectionViewLayout] invalidateLayout];
    [self.collectionView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initDefaultData];
    [self initCollectionView];
}

//-(void)initDefaultData{
//    NSArray *sandBoxPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsPath = [sandBoxPath objectAtIndex:0];
//    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"userInfo.plist"];
//}

- (void)initCollectionView{
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    _viewModel = [[HTSProfileViewModel alloc] init];
    _itemWidth = (SCREEN_WIDTH - (CGFloat)(((NSInteger)(SCREEN_WIDTH)) % numOfColumns) ) / 3.0f - 1.0f;
    _itemHeight = _itemWidth * 1.35f;
//    [self rac_liftSelector:@selector(refreshTableView:) withSignals:_viewModel.dataSignal, nil];
//    [_viewModel.loadDataCommand execute:nil];
    
    [self refreshTableView:[_viewModel loadVideoData]];
    [self.view addSubview:_collectionView];
    
}

- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.headerReferenceSize = CGSizeMake(100, 40);
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[HTSVideoCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        [_collectionView registerClass:[HTSProfileHeader class]
               forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                      withReuseIdentifier:headerIdentifier];
    }
    return _collectionView;
}

- (void)refreshTableView:(NSArray *)cellViewModelArray
{
    self.cellViewModelArray = cellViewModelArray;
    [self.collectionView reloadData];
    [self.collectionView.refreshControl endRefreshing];
}

//- (void)refreshTableView:(NSArray *)cellViewModelArray
//{
//    self.cellViewModelArray = cellViewModelArray;
//    [self.collectionView reloadData];
//    [self.collectionView.refreshControl endRefreshing];
//}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"numOfSections");
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_cellViewModelArray count];
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HTSVideoCollectionViewCell *cell =
    (HTSVideoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                                              forIndexPath:indexPath];
    HTSVideoModel *video = self.cellViewModelArray[indexPath.row];
//    [cell bindWithViewModel:cellViewModel];
//    [cell.coverImageView sd_setImageWithURL:[NSURL URLWithString:cell.imageURL] placeholderImage:[UIImage imageNamed:@"cover"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            if (image) {
//                [cell.coverImageView setImage:image];
//            }
//    }];
    [cell updateWithImageURL:video.coverAddr likeCount:video.likeCount];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake(_itemWidth, _itemHeight);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
  HTSProfileHeader *reusableView = nil;

  if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
      reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                      withReuseIdentifier:headerIdentifier
                                                             forIndexPath:indexPath];
      _profileHeader = reusableView;
      reusableView.delegate = self;
  }
  return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 200 + SAFE_AREA_TOP_HEIGHT);
    }
    return CGSizeZero;
}

- (void)onUserActionTap:(NSInteger)tag {
    switch (tag) {
        case HTSProfileHeaderEditTag:{
            HTSEditViewController* editViewController = [[HTSEditViewController alloc] init];
            [self.navigationController pushViewController:editViewController animated:YES];
            //editViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            //[self presentViewController:editViewController animated:YES completion:nil];
            NSLog(@"Edit button tapped");
            break;
        }
        default:
            break;
    }
}



@end
