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

#define CELL_COUNT 30
#define CELL_IDENTIFIER @"HTSVideoCollectionViewCell"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface HTSProfileViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *videos;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;

@end

@implementation HTSProfileViewController

- (NSMutableArray *)videos{
    if (!_videos) {
        HTSVideoModel *video1 = [[HTSVideoModel alloc] init];
        video1.coverAddr = @"http://p9.pstatp.com/large/8fb9000a620557d48e9f.jpeg";
        video1.likeCount = 15;
        PlayAddress *playAddr = [[PlayAddress alloc] init];
        playAddr.uri = @"v0200ff70000bck86n4mavf9lsqsr7m0";
        playAddr.urlList = @[@"https://aweme.snssdk.com/aweme/v1/play/?video_id=v0200ff70000bck86n4mavf9lsqsr7m0&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0", @"https://api.amemv.com/aweme/v1/play/?video_id=v0200ff70000bck86n4mavf9lsqsr7m0&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0", @"https://aweme.snssdk.com/aweme/v1/play/?video_id=v0200ff70000bck86n4mavf9lsqsr7m0&line=1&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0", @"https://api.amemv.com/aweme/v1/play/?video_id=v0200ff70000bck86n4mavf9lsqsr7m0&line=1&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0"];
        video1.playAddr = playAddr;
        video1.playCount = 135;
        video1.videoID = @"001";
        _videos = [[NSMutableArray alloc] init];
        [_videos addObject:video1];
    }
    return _videos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCollectionView];
    // Do any additional setup after loading the view.
    
    
}

-(void)initCollectionView{
    _itemWidth = (SCREEN_WIDTH - (CGFloat)(((NSInteger)(SCREEN_WIDTH)) % 3) ) / 3.0f - 1.0f;
    _itemHeight = _itemWidth * 1.35f;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(100, 40);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor grayColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[HTSVideoCollectionViewCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
    [self.view addSubview:_collectionView];
    NSLog(@"initCollectionView");
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"numOfItemsInSection");
    return CELL_COUNT;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"numOfSections");
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HTSVideoCollectionViewCell *cell =
    (HTSVideoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
                                                                              forIndexPath:indexPath];
    HTSVideoModel * video = [_videos objectAtIndex:0];
    NSLog(@"pathAtIndex");
    [cell initWithVideo:video];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"sizeForItemAtindexpath");
    return  CGSizeMake(_itemWidth, _itemHeight);
}

@end
