//
//  ViewController.m
//  Calculator
//
//  Created by lee Neil on 1/26/16.
//  Copyright © 2016 lee Neil. All rights reserved.
//

#import "ViewController.h"

// represent current operation state
typedef NS_ENUM(NSUInteger, OperationType) {
    //init operation state, and state when result button clicks
    OperationTypeResult,
    // sum state, when sum button clicks
    OperationTypeSum,
    // subtract state, when subtract button clicks
    OperationTypeSubtraction,
    // Multiply state, when multiply button clicks
    OperationTypeMultiplication,
    // Division state, when divide button clicks
    OperationTypeDivision
};


@interface ViewController ()
// ui widget used to display input result and calculate result
@property (weak, nonatomic  ) IBOutlet UILabel         *resultLabel;

// collection of operation buttons (sum, subtract, multiply, divide)
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *operationBtns;


// NSMutableString used deal with format before used to set resultLabel
@property (nonatomic, strong) NSMutableString *displayStr;

// previous number that is used to calculate,
// could be input or result,
// normally refer to number before Operation
@property (nonatomic, assign) double          previousNumber;

// inputing number, number after operation (sum, subtract, multiply, divide)
@property (nonatomic, assign) double          currentNumber;

// calculated result
@property (nonatomic, assign) double          result;
@property (nonatomic, assign) OperationType   currentOperation;

// when last operation is OperationRyeResult, this is used.
// this is for dealing operations like "= = = ="
@property (nonatomic, assign) OperationType   previousOperation;

// flag represent if there's uncalculated procedure
@property (nonatomic, assign) int             count;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    //    btn.layer.borderWidth
    _displayStr = [NSMutableString new];
    
    [self clear:nil];
}


#pragma mark - operators

- (IBAction)divide:(id)sender {
    [self operationBtnSelected:sender];
    [self calculateOperate];
    _currentOperation = OperationTypeDivision;
}

- (IBAction)multiply:(id)sender {
    [self operationBtnSelected:sender];
    [self calculateOperate];
    _currentOperation = OperationTypeMultiplication;
}

- (IBAction)subtract:(id)sender {
    [self operationBtnSelected:sender];
    [self calculateOperate];
    _currentOperation = OperationTypeSubtraction;
}

- (IBAction)add:(id)sender {
    [self operationBtnSelected:sender];
    [self calculateOperate];
    _currentOperation = OperationTypeSum;
    
}

- (void)recoverOperationBtnState {
    for (UIButton *btn in _operationBtns) {
        btn.layer.borderWidth = 0;
    }
}

- (void)operationBtnSelected:(id)sender {
    [self recoverOperationBtnState];
    UIButton *button = sender;
    button.layer.borderWidth = 2;
}

- (void)calculateOperate {
    // if there's continuous operators, print the result first.
    // _count > 0 means there's procedure that is not calculated
    // before this operator
    if (_count > 0) {
        [self getResult];
        _count = 0;
    }
    [_displayStr setString:@""];
    
    if (_currentOperation == OperationTypeResult) {
        _previousNumber = _result;
    }else{
        _previousNumber = _currentNumber;
    }
    _count += 1;
}


- (IBAction)getResult {
    
    // for continuous "= = ="
    if (_currentOperation == OperationTypeResult) {
        _currentOperation = _previousOperation;
    }else {
        _previousOperation = _currentOperation;
    }
    
    if (_currentOperation == OperationTypeSum) {
        
        _result = _previousNumber + _currentNumber;
        
    } else if (_currentOperation == OperationTypeSubtraction) {
        
        _result = _previousNumber - _currentNumber;
        
    } else if (_currentOperation == OperationTypeMultiplication) {
        
        _result = _previousNumber * _currentNumber;
        
    } else if (_currentOperation == OperationTypeDivision) {
        
        _result = _previousNumber / _currentNumber;
    }
    NSString *stringResult = [NSString stringWithFormat:@"%.15g", _result];
    [_displayStr setString:stringResult];
    [_resultLabel setText:_displayStr];
    [_displayStr setString:@"0"];
    _previousNumber = _result;
    _count = 0;
    _currentOperation = OperationTypeResult;
}



#pragma mark - numbers

- (IBAction)clear:(id)sender {
    [self recoverOperationBtnState];
    _previousNumber = 0;
    _currentNumber = 0;
    _result = 0;
    _count = 0;
    _currentOperation = OperationTypeResult;
    [_displayStr setString:@"0"];
    [_resultLabel setText:_displayStr];
}

- (void)addDigitToDisplay:(NSString *)string {
    
    // prevent 0...123
    if ([string isEqualToString:@"."]) {
        if ( _displayStr.length > 0 && ([_displayStr characterAtIndex:_displayStr.length - 1] != '.')) {
            [_displayStr appendString:string];
        }else {
            return;
        }
    }else {
        [_displayStr appendString:string];
    }
    
    // prevent 0123
    if (_displayStr.length >= 2 && [_displayStr characterAtIndex:0] == '0' && [_displayStr characterAtIndex:1] != '.') {
        [_displayStr deleteCharactersInRange: NSMakeRange(0, 1)];
    }
    
    _currentNumber = [_displayStr doubleValue];
    _result = _currentNumber;
    _previousOperation = OperationTypeResult;
    [_resultLabel setText:_displayStr];
    
}

- (IBAction)zero:(id)sender {
    [self recoverOperationBtnState];
    [self addDigitToDisplay:@"0"];
}

- (IBAction)one:(id)sender {
    [self recoverOperationBtnState];
    [self addDigitToDisplay:@"1"];
}

- (IBAction)two:(id)sender {
    [self recoverOperationBtnState];
    [self addDigitToDisplay:@"2"];
}

- (IBAction)three:(id)sender {
    [self recoverOperationBtnState];
    [self addDigitToDisplay:@"3"];
}

- (IBAction)four:(id)sender {
    [self recoverOperationBtnState];
    [self addDigitToDisplay:@"4"];
}

- (IBAction)five:(id)sender {
    [self recoverOperationBtnState];
    [self addDigitToDisplay:@"5"];
}

- (IBAction)six:(id)sender {
    [self recoverOperationBtnState];
    [self addDigitToDisplay:@"6"];
}

- (IBAction)seven:(id)sender {
    [self recoverOperationBtnState];
    [self addDigitToDisplay:@"7"];
}

- (IBAction)eight:(id)sender {
    [self recoverOperationBtnState];
    [self addDigitToDisplay:@"8"];
}

- (IBAction)nine:(id)sender {
    [self recoverOperationBtnState];
    [self addDigitToDisplay:@"9"];
}

- (IBAction)decimal:(id)sender {
    [self recoverOperationBtnState];
    [self addDigitToDisplay:@"."];
}

- (IBAction)minus:(id)sender {
    [self recoverOperationBtnState];
    
    // scenario +/- : when get result then press +/-
    if (_currentOperation == OperationTypeResult) {
        _previousOperation = OperationTypeResult;
        _currentNumber = _result;
        
    }
    
    // press +/- after
    
    _currentNumber *= -1;
    _result = _currentNumber;
    [_displayStr setString:[NSString stringWithFormat:@"%g",_currentNumber]];
    _resultLabel.text = _displayStr;
}

- (IBAction)percent:(id)sender {
    [self recoverOperationBtnState];
    
    // scenario % : when get result then press %
    if (_currentOperation == OperationTypeResult) {
        _previousOperation = OperationTypeResult;
        _currentNumber = _result;
    }
    _currentNumber /= 100.0;
    _result = _currentNumber;
    
    [_displayStr setString:[NSString stringWithFormat:@"%g",_currentNumber]];
    _resultLabel.text = _displayStr;
}




@end
