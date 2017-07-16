//
//  BankTableViewCell.m
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import "BankTableViewCell.h"
#import <Haneke/Haneke.h>

@implementation BankTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForBank:(Bank *)bank {
    if (!bank) return;
    
    self.bank = bank;
    [self.iconImageView hnk_setImageFromURL:bank.secureThumbnail];
    self.titleLabel.text = bank.name;
        
}

@end
