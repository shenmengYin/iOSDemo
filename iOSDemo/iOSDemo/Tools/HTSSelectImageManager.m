//
//  HTSSelectImageManager.m
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-08-10.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import "HTSSelectImageManager.h"



@implementation HTSSelectImageManager

UIViewController *presentController;

-(instancetype)initWithViewController:(UIViewController *)viewController{
    self = [super init];
    if (self) {
        //在初始化方法中给presentController赋值
        presentController = viewController;
    }
    return self;
}

-(void)selectImageWithAlbum{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    //允许编辑
    imagePickerController.allowsEditing = YES;
    //设置sourceType为UIImagePickerControllerSourceTypePhotoLibrary，代表调取相册
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if (presentController) {
        //从需要更换图片的界面跳转到选择图片界面
        [presentController presentViewController:imagePickerController animated:YES completion:nil];
        //选择完成后执行代理方法imagePickerController:idFinishPickingMediaWithInfo:
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取所选择的图片
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    if (!image) {
        image = info[@"UIImagePickerControllerOriginalImage"];
    }
    if (_deleagte && [_deleagte respondsToSelector:@selector(didChooseImage:)]) {
        //获取到图片之后执行该方法，并将图片作为参数传给需要更换图片的viewcontroller
        [self.deleagte didChooseImage:image];
    }
    //跳转会需要更换图片的界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)selectImageWithCamera{
    if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
        NSLog(@"no camera");
        return;
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [presentController presentViewController:imagePickerController animated:YES completion:nil];
    //[imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

@end
