//
//  ViewController.m
//  Hive
//
//  Created by Robert Short on 12/26/21.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSArray *peoplePickerData, *tipPickerData;
    NSString *output, *numberOfPeople, *tipSelection, *cleaned, *newTotal, *newTip, *newTotalPerPerson, *eachSavings;
    NSInteger tipRow, peopleRow, peopleNumber;
    CGFloat selection, totalInt, tipValue, totalWithTip, totalperPerson, savings;
}

@property (weak, nonatomic) IBOutlet UITextField *checkAmountText;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UILabel *tip;
@property (weak, nonatomic) IBOutlet UILabel *each;
@property (weak, nonatomic) IBOutlet UILabel *eachSaves;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    peoplePickerData = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", @"10"];
    tipPickerData = @[@"0%",@"5%",@"10%",@"15%",@"20%",@"25%",@"30%",@"35%",@"40%",@"45%",@"50%"];
    
    self.peoplePicker.dataSource = self;
    self.peoplePicker.delegate = self;
    
    self.tipPicker.dataSource = self;
    self.tipPicker.delegate = self;
    
    [_checkAmountText addTarget:self action:@selector(textFieldDidChangeSelection:) forControlEvents:UIControlEventEditingChanged];
    
}

- (void)calculate {
    tipRow = [_tipPicker selectedRowInComponent:0];
    peopleRow = [_peoplePicker selectedRowInComponent:0];
    
    output = _checkAmountText.text;
    totalInt = [output floatValue];
    
    tipSelection = [tipPickerData objectAtIndex:tipRow];
    cleaned = [tipSelection stringByReplacingOccurrencesOfString:@"%" withString:@""];
    selection = [cleaned floatValue];
    tipValue = totalInt / 100 * selection;
    newTip = [NSString stringWithFormat:@"$%.2f", (CGFloat)tipValue];
    
    totalWithTip = totalInt + tipValue;
    newTotal = [NSString stringWithFormat:@"$%.2f", (CGFloat)totalWithTip];

    numberOfPeople = [peoplePickerData objectAtIndex:peopleRow];
    peopleNumber = [numberOfPeople integerValue];
    totalperPerson = totalWithTip / peopleNumber;
    newTotalPerPerson = [NSString stringWithFormat:@"$%.2f", (CGFloat)totalperPerson];
    
    savings = totalWithTip - totalperPerson;
    eachSavings = [NSString stringWithFormat:@"$%.2f", savings];
    
    [_total setText:newTotal];
    [_tip setText:newTip];
    [_each setText:newTotalPerPerson];
    [_eachSaves setText:eachSavings];
}

- (void)textFieldDidChangeSelection:(UITextField *)textField
{
    [self calculate];

}

-(NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == 1)
        return peoplePickerData.count;
    else
        return tipPickerData.count;
    
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == 1)
        return peoplePickerData[row];
    else
        return tipPickerData[row];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == 1)
        row = peopleRow;
    else
        row = tipRow;
    
    [self calculate];
}

@end
