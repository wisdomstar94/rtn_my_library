#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <Photos/PHPhotoLibrary.h>
#import "ImagePickerControllerViewController.h"

@implementation ImagePickerControllerViewController

- (void)viewDidLoad {
    NSLog(@"viewDidLoad!");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (BOOL)viewDidAppear {
    NSLog(@"viewDidAppear!");
    return YES;
}

- (void)chooseImage {
    UIViewController *uvc = [[[UIApplication sharedApplication] delegate].window rootViewController];
  
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // [self presentViewController:imagePicker animated:YES completion:nil];
    [uvc presentViewController:imagePicker animated:YES completion:nil];
  
    // [self presentModalViewController:imagePicker animated:YES];
    // [self.navigationController pushViewController:imagePicker animated:YES];
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
