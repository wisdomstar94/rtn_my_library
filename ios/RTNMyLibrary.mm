#import "RTNMyLibrary.h"
#import <sys/utsname.h>
#import "ImagePickerControllerViewController.h"

@interface RTNMyLibrary ()

@property (nonatomic, strong) ImagePickerControllerViewController *imagePickerController;

@end

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
  self.imagePickerController = [[ImagePickerControllerViewController alloc] init];
  __weak __typeof__(self) weakSelf = self;
  self.imagePickerController.imageSelectionCallback = ^(NSDictionary *imageInfo) {
    NSLog(@"Selected Image Info: %@", imageInfo);
    resolve(@"success");
//    [weakSelf handleImageSelection:imageInfo];
  };
  [self.imagePickerController chooseImage];
  
//  [self selectImage];
//  [ImagePickerManager.store getGallery:^(UIImage * image) {
//    //get image
//    resolve(@"success");
//  } cancelHandler:^{
//    //user cancel
//    resolve(@"cancel");
//  }];
}

//- (void)handleImageSelection:(NSDictionary *)imageInfo {
//    // Handle selected image info here
//    NSLog(@"Selected Image Info: %@", imageInfo);
//}

-(std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeRtnMyLibrarySpecJSI>(params);
}
//#endif

@end
