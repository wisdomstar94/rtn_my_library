#import <Photos/Photos.h>
#import <Photos/PHPhotoLibrary.h>
#import "ImagePickerControllerViewController.h"

@implementation ImagePickerControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)chooseImage {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
    UIImage *selectedImage = info[UIImagePickerControllerOriginalImage];
    NSMutableDictionary *imageInfo = [NSMutableDictionary dictionary];
    [imageInfo setObject:selectedImage forKey:@"image"];
    if (self.imageSelectionCallback) {
        self.imageSelectionCallback(imageInfo);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
