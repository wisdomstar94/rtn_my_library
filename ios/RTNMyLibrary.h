#import <RTNMyLibrarySpec/RTNMyLibrarySpec.h>

NS_ASSUME_NONNULL_BEGIN

@interface RTNMyLibrary : NSObject <NativeRtnMyLibrarySpec, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UIImagePickerController *imagePicker;

-(void)getDeviceModel:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject;
-(void)requestGalleryImage:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject;

@end

NS_ASSUME_NONNULL_END
