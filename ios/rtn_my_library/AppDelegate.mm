#import "AppDelegate.h"
#import "ImagePickerControllerViewController.h"
#import <React/RCTBundleURLProvider.h>
#import "RTNMyLibrary.h"
//#import "ImagePickerManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.moduleName = @"rtn_my_library";
  // You can add your custom initial props in the dictionary below.
  // They will be passed down to the ViewController used by React Native.
  self.initialProps = @{};

  RTNMyLibrary* lib = [[RTNMyLibrary alloc] init];
  [lib getDeviceModel:^(id result) {
    NSLog(@"test ::: %@", result);
  } reject:^(NSString *code, NSString *message, NSError *error) {
    // ...
  }];
  
//  [ImagePickerManager.store getGallery:self pickImageHandler:^(UIImage * image) {
//     //get image
//  } cancelHandler:^{
//      //user cancel
//  }];
  
  
  PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
  switch (status) {
      case PHAuthorizationStatusAuthorized:
          // 이미 권한이 허용되어 있음
          NSLog(@"이미 권한이 허용되어 있음");
          break;
      case PHAuthorizationStatusNotDetermined:
          // 권한을 요청함
          {
                NSLog(@"권한을 요청함");
//                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        if (status == PHAuthorizationStatusAuthorized) {
//                            // 권한이 허용되었을 때만 갤러리를 엽니다.
//                            self.imagePickerController = [[ImagePickerControllerViewController alloc] init];
//                            __weak __typeof__(self) weakSelf = self;
//                            self.imagePickerController.imageSelectionCallback = ^(NSDictionary *imageInfo) {
//                              NSLog(@"Selected Image Info: %@", imageInfo);
//                              resolve(@"success");
//                              // [weakSelf handleImageSelection:imageInfo];
//                            };
//                            [self.imagePickerController chooseImage];
//                        } else {
//                            // 권한이 거부되었거나 제한되었을 때의 처리
//                            NSLog(@"갤러리 접근 권한이 거부되었습니다.");
//                            resolve(@"permission-deny");
//                            // 사용자에게 권한 설정을 변경하도록 알릴 수 있습니다.
//                        }
//                    });
//                }];
          }
          break;
      case PHAuthorizationStatusDenied:
      case PHAuthorizationStatusRestricted:
          // 권한이 거부되었거나 제한되었음
          NSLog(@"갤러리 권한이 거부되었습니다.");
          break;
      default:
          break;
  }
  
  
  
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  return [self bundleURL];
}

- (NSURL *)bundleURL
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

@end
