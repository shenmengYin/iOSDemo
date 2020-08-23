//
//  HTSProfileViewModel.m
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-07-19.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import "HTSProfileViewModel.h"
#import "HTSVideoModel.h"
#import "HTSVideoCellViewModel.h"

#import <Mantle/Mantle.h>
#import <AFNetworking/AFNetworking.h>

@interface HTSProfileViewModel ()
@property (nonatomic) RACCommand *loadDataCommand;
@property (nonatomic) RACSignal *dataSignal;
@property (nonatomic) RACSignal *errorSignal;
@end

@implementation HTSProfileViewModel

//static BOOL useLiveData = NO;

- (instancetype)init{
    self = [super init];
    if (self) {
        _dataSignal = [[self.loadDataCommand.executionSignals flattenMap:^RACStream *(RACSignal *dataSignal) {
            return [dataSignal map:^id (NSArray *videoArray) {
                return [[[videoArray rac_sequence] map:^id (HTSVideoModel *video) {
                    HTSVideoCellViewModel *viewModel = [[HTSVideoCellViewModel alloc] initWithVideo:video];
                    return viewModel;
                }] array];
            }];
        }] deliverOnMainThread];
        _errorSignal = self.loadDataCommand.errors;
    }
    return self;
}

- (RACCommand *)loadDataCommand{
    if (!_loadDataCommand) {
        _loadDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            RACSignal *videoSignal;
//            if(useLiveData){
//                videoSignal = [self loadVideoDataLive];
//            }
//            else{
//                videoSignal = [self loadVideoData];
//            }
            videoSignal = [self loadVideoData];
            return videoSignal;
        }];
    }
    return _loadDataCommand;
}

- (RACSignal *)loadVideoData{
    return [[RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSError *error = nil;

        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error ];

        if (error) {
            [subscriber sendError:error];
        } else {
            NSArray *videoData = jsonData[@"data"];
            if (!videoData) {
                [subscriber sendError:[NSError errorWithDomain:@"Error JSON Data" code:500 userInfo:@{}]];
            } else {
                NSArray *videoArray = [MTLJSONAdapter modelsOfClass:HTSVideoModel.class fromJSONArray:videoData error:&error];

                if (error) {
                    [subscriber sendError:error];
                } else {
                    [subscriber sendNext:videoArray];
                    [subscriber sendCompleted];
                }
            }
        }
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }] subscribeOn:[RACScheduler schedulerWithPriority:DISPATCH_QUEUE_PRIORITY_DEFAULT]];
}

- (RACSignal *)loadVideoDataLive{
    return [[RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
        //AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //manager.requestSerializer.timeoutInterval = 30.0f;
        
        
        NSString *urlString = @"http://localhost.charlesproxy.com:3000/mock";
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:urlString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"success: %@ -- %@", [responseObject class], responseObject);
            //NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            NSError *error = nil;
            if (error) {
                [subscriber sendError:error];
            } else {
                NSArray *videoData = responseObject[@"data"];
                if (!videoData) {
                    [subscriber sendError:[NSError errorWithDomain:@"Error JSON Data" code:500 userInfo:@{}]];
                } else {
                    NSArray *videoArray = [MTLJSONAdapter modelsOfClass:HTSVideoModel.class fromJSONArray:videoData error:&error];

                    if (error) {
                        [subscriber sendError:error];
                    } else {
                        [subscriber sendNext:videoArray];
                        [subscriber sendCompleted];
                    }
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"failed");
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }] subscribeOn:[RACScheduler schedulerWithPriority:DISPATCH_QUEUE_PRIORITY_DEFAULT]];
}

@end
