//
//  ViewController.m
//  SimpleCalculator - 5th lesson
//
//  Created by Kemuel Clyde Belderol on 16/03/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelResult;
@property (strong, nonatomic)IBOutletCollection(UIButton) NSArray *calculatorButtons;
@property (strong, nonatomic) NSString *currentOperator;
@property (assign, nonatomic) double savedValue;
@property (assign, nonatomic) BOOL operatorPressed;
@property (strong, nonatomic) NSNumberFormatter *formatter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.calculatorButtons objectAtIndex:0];
//    self.calculatorButtons[0];
    
    for (UIButton *button in self.calculatorButtons) {
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.formatter= [[NSNumberFormatter alloc] init];
    self.formatter.numberStyle = NSNumberFormatterDecimalStyle;
    self.formatter.maximumFractionDigits = 20;
    
}

-(void)buttonPressed:(UIButton *)sender {
    
    NSString *buttonText = sender.titleLabel.text;
    
    NSArray *numberStrings = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
    
    NSArray *operatorStrings = @[@"+", @"-", @"x", @"÷"];
    
    //number press
    
    if([numberStrings containsObject:buttonText]) {
        
        if(self.operatorPressed) {
            self.labelResult.text = buttonText;
            self.operatorPressed = NO;
            return;
        }

        if([self.labelResult.text isEqualToString:@"0"]) {
            self.labelResult.text = buttonText;
        } else {
        
        self.labelResult.text =[NSString stringWithFormat:@"%@%@", self.labelResult.text, buttonText];
        }
    } else if ( [buttonText isEqualToString:@"."]) {
        
        //press .
        
        if([self.labelResult.text rangeOfString:@"."].location < self.labelResult.text.length) {
            return;
        }
             self.labelResult.text = [NSString stringWithFormat:@"%@%@", self.labelResult.text, buttonText];
        
    //AC press
        
    } else if ([buttonText isEqualToString:@"AC"]) {
        self.labelResult.text = @"0";
        self.operatorPressed = NO;
        self.savedValue = 0.0;
        self.currentOperator = @"";
    } else if ([operatorStrings containsObject:buttonText]) {
        [self calculate];
        self.savedValue = [self.labelResult.text doubleValue];
        self.currentOperator = buttonText;
        self.operatorPressed = YES;
        //do operation
        //store previous value
        //store the current operator
        
    } else if ([buttonText isEqualToString:@"="]) {
        [self calculate];
        
        
        
        //calculate
        //update text
    } else if ([buttonText isEqualToString:@"%"]) {
        double percentageValue = [self.labelResult.text doubleValue]/100;
        self.labelResult.text = [self.formatter stringFromNumber:[NSNumber numberWithDouble:percentageValue]];
        
        //get the percentage value
    } else {
        double minValue = -[self.labelResult.text doubleValue];
        self.labelResult.text = [self.formatter stringFromNumber: [NSNumber numberWithDouble:minValue]];
        //convert to it's negative value if positive value vice versa
    }
    
}



- (void)calculate {
    double result;
    double currentValue = [self.labelResult.text doubleValue];
    
    if([self.currentOperator isEqualToString:@"+"]) {
        result = self.savedValue + currentValue;
        
    } else if ([self.currentOperator isEqualToString:@"-"]) {
        result = self.savedValue - currentValue;
        
    } else if ([self.currentOperator isEqualToString:@"x"]) {
        result = self.savedValue * currentValue;
        
    } else if ([self.currentOperator isEqualToString:@"÷"]) {
        result = self.savedValue/currentValue;
    } else {
        return;
    }
   
    self.labelResult.text = [self.formatter stringFromNumber:[NSNumber numberWithDouble:result]];
    }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




@end
