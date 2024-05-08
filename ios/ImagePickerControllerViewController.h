#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImagePickerControllerViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, copy) void (^imageSelectionCallback)(NSDictionary *info);

- (void)chooseImage;

@end

NS_ASSUME_NONNULL_END
