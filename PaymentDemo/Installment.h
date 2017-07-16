//
//  Installment.h
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Amount.h"

@interface Installment : NSObject

@property (strong, nonatomic) NSNumber *number;
@property (strong, nonatomic) NSNumber *rate;
@property (strong, nonatomic) NSNumber *discountRate;
@property (strong, nonatomic) NSArray *labels;
@property (strong, nonatomic) NSString *rateCollector;
@property (strong, nonatomic) NSString *recommendedMessage;
@property (strong, nonatomic) Amount *amount;
@property (strong, nonatomic) Amount *totalAmount;

+ (instancetype) instanceFromDictionary:(NSDictionary *) dictionary;

@end
