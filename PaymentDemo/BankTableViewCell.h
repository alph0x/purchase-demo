//
//  BankTableViewCell.h
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bank.h"

@interface BankTableViewCell : UITableViewCell

@property (strong, nonatomic) Bank *bank;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void) prepareForBank:(Bank *) bank;

@end
