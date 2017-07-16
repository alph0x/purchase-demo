//
//  EnterAmountViewController.h
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sale.h"

@interface EnterAmountViewController : UIViewController

@property(strong, nonatomic) Sale *sale;

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numericKeyboardButtons;

@property (weak, nonatomic) IBOutlet UIButton *purchaseButton;

- (IBAction)numericKeyboardButtonTapped:(UIButton *)sender;
- (IBAction)purchaseButtonTapped:(UIButton *)sender;

@end
