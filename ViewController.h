//
//  ViewController.h
//  Hive
//
//  Created by Robert Short on 12/26/21.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate> 

@property (weak, nonatomic) IBOutlet UIPickerView *peoplePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *tipPicker;

@end

