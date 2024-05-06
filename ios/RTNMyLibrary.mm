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
  [ImagePickerManager.store getGallery:^(UIImage * image) {
    //get image
    resolve(@"success");
  } cancelHandler:^{
    //user cancel
    resolve(@"cancel");
  }];
}

-(std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeRtnMyLibrarySpecJSI>(params);
}
//#endif

@end
