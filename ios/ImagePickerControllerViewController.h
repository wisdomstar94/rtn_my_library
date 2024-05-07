#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImagePickerControllerViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, copy) void (^imageSelectionCallback)(NSDictionary *imageInfo);

- (void)chooseImage;

@end

NS_ASSUME_NONNULL_END
