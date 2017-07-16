//
//  InstallmentTableViewCell.h
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Installment.h"

@interface InstallmentTableViewCell : UITableViewCell

@property (strong, nonatomic) Installment *installment;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *interestLabel;
@property (weak, nonatomic) IBOutlet UILabel *installmentAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;

- (void) prepareForInstallment:(Installment *) installment;

@end
