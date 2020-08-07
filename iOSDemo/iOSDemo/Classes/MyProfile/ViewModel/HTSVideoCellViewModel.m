//
//  HTSVideoCellViewModel.m
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-07-19.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import "HTSVideoCellViewModel.h"
#import "HTSVideoModel.h"
#import <SDWebImage/SDWebImage.h>
#import <SDWebImageDownloader.h>

@interface HTSVideoCellViewModel ()

@property (nonatomic) HTSVideoModel *video;

@end

@implementation HTSVideoCellViewModel

-(instancetype)initWithVideo:(HTSVideoModel *)video{
    if (self = [super init]) {
        self.cellName = @"HTSVideoCollectionViewCell";
        _video = video;
        [self bindSignals];

    }
    return self;
}

- (void)bindSignals
{
    RACSignal *videoSignal = [RACSignal return :self.video];

    self.coverImageSignal = [[[videoSignal map:^id (HTSVideoModel *video) {
        return video.coverAddr;
    }] subscribeOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground]]
    deliverOnMainThread];

    self.likeCountSignal = [videoSignal map:^id (HTSVideoModel *video) {
        return @(video.likeCount);
    }];
    
    self.playCountSignal = [videoSignal map:^id (HTSVideoModel *video) {
        return @(video.playCount);
    }];

    self.displaySignal = [videoSignal map:^id (HTSVideoModel *video) {
        if(video.likeCount < 10){
         
            return [NSString stringWithFormat:@"%ld", (long) video.playCount];
        }
        else{
 
            return [NSString stringWithFormat:@"%ld", (long) video.likeCount];
        }
    }];

}


@end
