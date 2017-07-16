//
//  Sale.h
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Amount.h"
#import "PaymentMethod.h"
#import "Bank.h"
#import "Installment.h"

@interface Sale : NSObject

@property (strong, nonatomic) Amount *amount;
@property (strong, nonatomic) PaymentMethod *paymentMethod;
@property (strong, nonatomic) Bank *bank;
@property (strong, nonatomic) Installment *installment;


@end
