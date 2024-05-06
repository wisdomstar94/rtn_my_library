#import "ImagePickerManager.h"

static ImagePickerManager *_store;

@interface ImagePickerManager(){
    UIImagePickerController *picker;
    void (^pickImageHandler)(UIImage*);//이미지 콜백
    void (^cancelHandler)(void);//취소 콜백
}

@end
@implementation ImagePickerManager
+ (ImagePickerManager *) store{
    if (!_store){
        _store = [[ImagePickerManager alloc] init];
    }
    return _store;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
    }
    return self;
}

//앨범에서 가저오기
-(void)getGallery:(void (^)(UIImage*))pickImageHandler cancelHandler:(void (^)(void))cancelHandler {
    self->pickImageHandler = pickImageHandler;
    self->cancelHandler = cancelHandler;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [picker presentViewController:picker animated:true completion:nil];
}
//카메라에서 가저오기
-(void)getCamera:(UIViewController*)viewcontroller pickImageHandler:(void (^)(UIImage*))pickImageHandler cancelHandler:(void (^)(void))cancelHandler {
    self->pickImageHandler = pickImageHandler;
    self->cancelHandler = cancelHandler;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [viewcontroller presentViewController:picker animated:true completion:nil];
}

#pragma mark - imagePicker extenstion
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    if (cancelHandler){
        dispatch_async(dispatch_get_main_queue(), ^{
            self->cancelHandler();
        });
    }

    [picker dismissViewControllerAnimated:true completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage *image =(UIImage*)info[UIImagePickerControllerOriginalImage];
    
    if (pickImageHandler){
        dispatch_async(dispatch_get_main_queue(), ^{
            self->pickImageHandler(image);
        });
    }
    
    [picker dismissViewControllerAnimated:true completion:nil];
}

@end
