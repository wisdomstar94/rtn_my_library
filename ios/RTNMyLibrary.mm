#import <Photos/Photos.h>
#import <Photos/PHPhotoLibrary.h>
#import "RTNMyLibrary.h"
#import <sys/utsname.h>
#import "ImagePickerControllerViewController.h"

@implementation RTNMyLibrary

RCT_EXPORT_MODULE()

-(void)requestGalleryImage:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString* code = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString *result = [NSString stringWithFormat:@"...%@...%@", code, @"v0.0.38"];
    resolve(result);
}

-(void)getDeviceModel:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString* code = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString *result = [NSString stringWithFormat:@"...%@...%@", code, @"v0.0.38"];
    resolve(result);
}

-(std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const facebook::react::ObjCTurboModule::InitParams &)params {
    return std::make_shared<facebook::react::NativeRtnMyLibrarySpecJSI>(params);
}

@end
