#import "AppDelegate.h"
#import "ImagePickerControllerViewController.h"
#import <React/RCTBundleURLProvider.h>
#import "RTNMyLibrary.h"
//#import "ImagePickerManager.h"
#import "ImagePickerControllerViewController.h"

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
  
  [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(start) userInfo:nil repeats:NO];
 
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

-(void)start {
  NSLog(@"start called!");
  // START
  PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
  switch (status) {
    case PHAuthorizationStatusAuthorized:
      {
        [self check];
      }
      break;
    case PHAuthorizationStatusNotDetermined:
      // 권한을 요청함
      {
        if (@available(iOS 14.0, *)) {
          [PHPhotoLibrary requestAuthorizationForAccessLevel:PHAccessLevelReadWrite handler:^(__unused PHAuthorizationStatus status) {
            [self check];
          }];
        } else {
          [PHPhotoLibrary requestAuthorization:^(__unused PHAuthorizationStatus status) {
            [self check];
          }];
        }
      }
      break;
    case PHAuthorizationStatusDenied:
    case PHAuthorizationStatusRestricted:
      // 권한이 거부되었거나 제한되었음
      NSLog(@"갤러리 권한이 거부되었습니다");
      break;
    default:
      break;
  }
  // END
}

-(void)check {
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
        self.imagePickerController.imageSelectionCallback = ^(NSDictionary *info) {
          NSLog(@"[tag_a] Selected Image Info: %@", info);
          NSURL *imageURL = info[UIImagePickerControllerImageURL];
          NSLog(@"[tag_a] imageURL: %@", imageURL);
          NSString *uri = [imageURL absoluteString];
          NSLog(@"[tag_a] uri: %@", uri);
          // resolve(uri);
        };
        [weakSelf.imagePickerController chooseImage];
      }
      break;
    case PHAuthorizationStatusRestricted:
    case PHAuthorizationStatusDenied:
      NSLog(@"[tag_a] permission-deny");
      break;
    default:
      
      break;
  }
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
