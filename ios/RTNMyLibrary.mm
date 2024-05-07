#import <Photos/Photos.h>
#import <Photos/PHPhotoLibrary.h>
#import "RTNMyLibrary.h"
#import <sys/utsname.h>
#import "ImagePickerControllerViewController.h"

@implementation RTNMyLibrary

RCT_EXPORT_MODULE()

-(void)requestGalleryImage:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
  resolve(@"왜..?");
//  switch (status) {
//    case PHAuthorizationStatusAuthorized:
//      {
//        // 이미 권한이 허용되어 있음
//        // 권한이 허용되었을 때만 갤러리를 엽니다.
//        self.imagePickerController = [[ImagePickerControllerViewController alloc] init];
//        // __weak __typeof__(self) weakSelf = self;
//        self.imagePickerController.imageSelectionCallback = ^(NSDictionary *imageInfo) {
//          NSLog(@"Selected Image Info: %@", imageInfo);
//          UIImage *selectedImage = imageInfo[UIImagePickerControllerOriginalImage];
//          NSURL *imageUrl = imageInfo[UIImagePickerControllerImageURL];
//          NSString *uri = [imageUrl absoluteString];
//          resolve(uri);
//        };
//        [self.imagePickerController chooseImage];
//      }
//      break;
//    case PHAuthorizationStatusNotDetermined:
//      // 권한을 요청함
//      {
//        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//          dispatch_async(dispatch_get_main_queue(), ^{
//            if (status == PHAuthorizationStatusAuthorized) {
//              // 권한이 허용되었을 때만 갤러리를 엽니다.
//              self.imagePickerController = [[ImagePickerControllerViewController alloc] init];
//              // __weak __typeof__(self) weakSelf = self;
//              self.imagePickerController.imageSelectionCallback = ^(NSDictionary *imageInfo) {
//                NSLog(@"Selected Image Info: %@", imageInfo);
//                UIImage *selectedImage = imageInfo[UIImagePickerControllerOriginalImage];
//                NSURL *imageUrl = imageInfo[UIImagePickerControllerImageURL];
//                NSString *uri = [imageUrl absoluteString];
//                resolve(uri);
//              };
//              [self.imagePickerController chooseImage];
//            } else {
//              // 권한이 거부되었거나 제한되었을 때의 처리
//              NSLog(@"갤러리 접근 권한이 거부되었습니다.");
//              resolve(@"permission-deny");
//              // 사용자에게 권한 설정을 변경하도록 알릴 수 있습니다.
//            }
//          });
//        }];
//      }
//      break;
//    case PHAuthorizationStatusDenied:
//    case PHAuthorizationStatusRestricted:
//      // 권한이 거부되었거나 제한되었음
//      NSLog(@"갤러리 권한이 거부되었습니다.");
//      resolve(@"permission-deny");
//      break;
//    default:
//      break;
//  }
}

-(void)getDeviceModel:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString* code = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString *result = [NSString stringWithFormat:@"...%@...%@", code, @"v0.0.40"];
    resolve(result);
}

-(std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const facebook::react::ObjCTurboModule::InitParams &)params {
    return std::make_shared<facebook::react::NativeRtnMyLibrarySpecJSI>(params);
}

@end
