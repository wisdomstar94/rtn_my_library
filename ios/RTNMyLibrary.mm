#import <Photos/Photos.h>
#import <Photos/PHPhotoLibrary.h>
#import <PhotosUI/PhotosUI.h>
#import "RTNMyLibrary.h"
#import <sys/utsname.h>
#import "ImagePickerControllerViewController.h"

@implementation RTNMyLibrary

RCT_EXPORT_MODULE()

-(void)requestGalleryImage:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
  switch (status) {
    case PHAuthorizationStatusAuthorized:
      {
        [self checkWithResolver:resolve rejecter:reject];
      }
      break;
    case PHAuthorizationStatusNotDetermined:
      // 권한을 요청함
      {
        if (@available(iOS 14.0, *)) {
          [PHPhotoLibrary requestAuthorizationForAccessLevel:PHAccessLevelReadWrite handler:^(__unused PHAuthorizationStatus status) {
            [self checkWithResolver:resolve rejecter:reject];
          }];
        } else {
          [PHPhotoLibrary requestAuthorization:^(__unused PHAuthorizationStatus status) {
            [self checkWithResolver:resolve rejecter:reject];
          }];
        }
      }
      break;
    case PHAuthorizationStatusDenied:
    case PHAuthorizationStatusRestricted:
      // 권한이 거부되었거나 제한되었음
      NSLog(@"갤러리 권한이 거부되었습니다.");
      resolve(@"permission-deny");
      break;
    default:
      break;
  }
}

-(void)getDeviceModel:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString* code = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString *result = [NSString stringWithFormat:@"...%@...%@", code, @"v0.0.44"];
    resolve(result);
}

- (void)checkWithResolver:(RCTPromiseResolveBlock _Nonnull)resolve
                 rejecter:(RCTPromiseRejectBlock _Nonnull)reject {
  PHAuthorizationStatus status;

  if (@available(iOS 14.0, *)) {
    status = [PHPhotoLibrary authorizationStatusForAccessLevel:PHAccessLevelReadWrite];
  } else {
    status = [PHPhotoLibrary authorizationStatus];
  }

  switch (status) {
    case PHAuthorizationStatusAuthorized:
    case PHAuthorizationStatusNotDetermined:
    case PHAuthorizationStatusLimited:
      {
        // 권한이 허용되었을 때만 갤러리를 엽니다.
        self.imagePickerController = [[ImagePickerControllerViewController alloc] init];
         __weak __typeof__(self) weakSelf = self;
        self.imagePickerController.imageSelectionCallback = ^(NSDictionary *imageInfo) {
          NSLog(@"Selected Image Info: %@", imageInfo);
          UIImage *selectedImage = imageInfo[UIImagePickerControllerOriginalImage];
          NSURL *imageUrl = imageInfo[UIImagePickerControllerImageURL];
          NSString *uri = [imageUrl absoluteString];
          resolve(uri);
        };
        [weakSelf.imagePickerController chooseImage];
      }
      break;
    case PHAuthorizationStatusRestricted:
    case PHAuthorizationStatusDenied:
      resolve(@"permission-deny");
      break;
    default:
      
      break;
  }
}

-(std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const facebook::react::ObjCTurboModule::InitParams &)params {
    return std::make_shared<facebook::react::NativeRtnMyLibrarySpecJSI>(params);
}

@end
