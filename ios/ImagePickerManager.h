#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface ImagePickerManager : NSObject<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

+(ImagePickerManager*)store;

-(void)getGallery:(void (^)(UIImage*))pickImageHandler
                    cancelHandler:(void (^)(void))cancelHandler;

-(void)getCamera:(UIViewController*)viewcontroller
                    pickImageHandler:(void (^)(UIImage*))pickImageHandler
                    cancelHandler:(void (^)(void))cancelHandler;
@end
