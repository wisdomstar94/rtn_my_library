#import <Photos/Photos.h>
#import <Photos/PHPhotoLibrary.h>
#import <RTNMyLibrarySpec/RTNMyLibrarySpec.h>
#import "ImagePickerControllerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RTNMyLibrary : NSObject <NativeRtnMyLibrarySpec>

@property (nonatomic, strong) ImagePickerControllerViewController *imagePickerController;
-(void)getDeviceModel:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject;
-(void)requestGalleryImage:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject;

@end

NS_ASSUME_NONNULL_END
