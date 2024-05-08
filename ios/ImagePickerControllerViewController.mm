#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <Photos/PHPhotoLibrary.h>
#import "ImagePickerControllerViewController.h"
#import <React/RCTConvert.h>
#import <React/RCTUtils.h>

@implementation ImagePickerControllerViewController

- (void)viewDidLoad {
    NSLog(@"[tag_a] viewDidLoad!");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//- (BOOL)viewDidAppear {
//    NSLog(@"[tag_a] viewDidAppear!");
//    return YES;
//}

- (void)chooseImage {
    // UIViewController *uvc = [[[UIApplication sharedApplication] delegate].window rootViewController];
    // UIViewController *root = RCTPresentedViewController();
  
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.modalPresentationStyle = UIModalPresentationAutomatic;
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    dispatch_async(dispatch_get_main_queue(), ^{
      UIViewController *root = RCTPresentedViewController();
      [root presentViewController:self.imagePicker animated:YES completion:nil];
    });
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"[tag_a] imagePickerControllerDidCancel called");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
    NSLog(@"[tag_a] imagePickerController called");
//    UIImage *selectedImage = info[UIImagePickerControllerOriginalImage];
//    NSMutableDictionary *imageInfo = [NSMutableDictionary dictionary];
//    [imageInfo setObject:selectedImage forKey:@"image"];
    if (self.imageSelectionCallback) {
        self.imageSelectionCallback(info);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//-(void)addChildViewController:(UIViewController *)childController {
//    // [super addChildViewController:<#childController#>]
//    [self addChildViewController:childController];
//    [self.view addSubview:childController.view];
//    [childController didMoveToParentViewController:self];
//}

@end
