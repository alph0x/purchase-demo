//
//  PaymentMethodTableViewCell.h
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentMethod.h"

@interface PaymentMethodTableViewCell : UITableViewCell

@property (strong, nonatomic) PaymentMethod *paymentMethod;

@property (weak, nonatomic) IBOutlet UIImageView *paymentMethodImageView;
@property (weak, nonatomic) IBOutlet UILabel *paymentMethodTitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *deferredCaptureImageView;
@property (weak, nonatomic) IBOutlet UILabel *deferredCaptureTitleLabel;

- (void) prepareForPaymentMethod:(PaymentMethod *) paymentMethod;

@end
