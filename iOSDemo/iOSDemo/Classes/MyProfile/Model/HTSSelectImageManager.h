//
//  HTSSelectImageManager.h
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-08-10.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol HTSSelectImageManagerDelegate <NSObject>
 
@optional
 
-(void)didChooseImage: (UIImage *) image;
 
@end
 
@interface HTSSelectImageManager : NSObject<HTSSelectImageManagerDelegate>
 
@property(nonatomic,weak) id<HTSSelectImageManagerDelegate> deleagte;
 
-(instancetype)initWithViewController:(UIViewController *)viewController;


-(void)selectImageWithAlbum;

-(void)selectImageWithCamera;
 
@end

NS_ASSUME_NONNULL_END
