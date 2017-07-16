//
//  EnterAmountViewController.m
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import "EnterAmountViewController.h"
#import "TableViewController.h"
#import "APIController.h"

@interface EnterAmountViewController () {
    NSNumberFormatter *numberFormatter;
}

@end

@implementation EnterAmountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sale = [Sale new];
    self.sale.amount = [Amount new];
    self.sale.amount.raw = [NSNumber numberWithInt:0];
    self.amountLabel.text = [self.sale.amount getFormattedAmount];
}

- (IBAction)numericKeyboardButtonTapped:(UIButton *)sender {
    
    NSString *buttonTitle = sender.titleLabel.text;
    
    if (buttonTitle.length == 0) { //deleteButton
        [self.sale.amount removeDigit];
        
    }else { //numberButton
        [self.sale.amount addDigit:buttonTitle];
    }
    
    self.amountLabel.text = [self.sale.amount getFormattedAmount];
    
}

- (IBAction)purchaseButtonTapped:(UIButton *)sender {
    if (self.sale.amount.raw.doubleValue == 0) {
        UIAlertController *error = [UIAlertController alertControllerWithTitle:nil
                                                                       message:@"Debes ingresar un monto para continuar."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [error addAction:okButton];
        [self presentViewController:error
                           animated:YES
                         completion:nil];
        
        return;
    }
    
    TableViewController *tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
    tableViewController.mode = tableViewModePaymentMethods;
    tableViewController.sale = self.sale;
    [self.navigationController pushViewController:tableViewController animated:YES];
}

@end
