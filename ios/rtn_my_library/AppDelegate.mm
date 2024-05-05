#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>
#import "RTNMyLibrary.h"

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
