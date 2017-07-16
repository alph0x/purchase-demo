//
//  InstallmentTableViewCell.m
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import "InstallmentTableViewCell.h"

@implementation InstallmentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForInstallment:(Installment *)installment {
    if (!installment) return;
    
    self.installment = installment;
    
    self.messageLabel.text = installment.recommendedMessage;
    
    __block NSString *interestString = @"";
    
    [installment.labels enumerateObjectsUsingBlock:^(NSString *s, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([s containsString:@"%"]) {
            interestString = s;
        }
        
    }];
    
    
    self.interestLabel.text = [interestString stringByReplacingOccurrencesOfString:@"_" withString:@" "];
}

@end
