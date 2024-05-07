#import "RTNMyLibrary.h"
#import <sys/utsname.h>
#import "ImagePickerManager.h"

@implementation RTNMyLibrary

RCT_EXPORT_MODULE()

//#ifdef RCT_NEW_ARCH_ENABLED
-(void)getDeviceModel:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString* code = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    resolve(code);
}

-(void)requestGalleryImage:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  [self selectImage];
//  [ImagePickerManager.store getGallery:^(UIImage * image) {
//    //get image
//    resolve(@"success");
//  } cancelHandler:^{
//    //user cancel
//    resolve(@"cancel");
//  }];
}

- (void)selectImage {
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    UIViewController *rootViewController = self.window.rootViewController;
    [rootViewController presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *selectedImage = info[UIImagePickerControllerOriginalImage];
    NSURL *imageUrl = info[UIImagePickerControllerImageURL];
    
    NSLog(@"Selected Image: %@", selectedImage);
    NSLog(@"Image URL: %@", imageUrl);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeRtnMyLibrarySpecJSI>(params);
}
//#endif

@end
