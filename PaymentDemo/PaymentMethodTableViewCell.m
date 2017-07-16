//
//  PaymentMethodTableViewCell.m
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import "PaymentMethodTableViewCell.h"
#import <Haneke/Haneke.h>
#import <ChameleonFramework/Chameleon.h>

@implementation PaymentMethodTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForPaymentMethod:(PaymentMethod *)paymentMethod {
    
    if (!paymentMethod) {
        return;
    }
    
    self.paymentMethod = paymentMethod;
    [self.paymentMethodImageView hnk_setImageFromURL:paymentMethod.secureThumbnail];
    self.paymentMethodTitleLabel.text = paymentMethod.name;
    
    
    UIImage *deferredCaptureIcon;
    NSString *deferredCaptureDescription;
    UIColor *deferredCaptureColor;
    
    switch (paymentMethod.deferredCapture) {
        case deferredCaptureNotApply:
        {
            deferredCaptureIcon = [UIImage imageNamed:@"NA-deferredCapture"];
            deferredCaptureDescription = @"No Aplica";
            deferredCaptureColor = [UIColor flatGrayColor];
        }
            break;
        case deferredCaptureUnsupported:
        {
            deferredCaptureIcon = [UIImage imageNamed:@"unsuported-deferredCapture"];
            deferredCaptureDescription = @"No Disponible";
            deferredCaptureColor = [UIColor flatRedColor];
        }
            break;
        case deferredCaptureSupported:
        {
            deferredCaptureIcon = [UIImage imageNamed:@"supported-deferredCapture"];
            deferredCaptureDescription = @"Disponible";
            deferredCaptureColor = [UIColor flatGreenColor];
        }
            break;
    }
    
    self.deferredCaptureImageView.tintColor = deferredCaptureColor;
    self.deferredCaptureImageView.image = deferredCaptureIcon;
    self.deferredCaptureTitleLabel.text = deferredCaptureDescription;
    self.deferredCaptureTitleLabel.textColor = deferredCaptureColor;
    
}

@end
