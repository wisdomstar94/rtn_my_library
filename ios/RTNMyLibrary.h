#import <RTNMyLibrarySpec/RTNMyLibrarySpec.h>

NS_ASSUME_NONNULL_BEGIN

@interface RTNMyLibrary : NSObject <NativeRtnMyLibrarySpec>

-(void)getDeviceModel:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject;

@end

NS_ASSUME_NONNULL_END
