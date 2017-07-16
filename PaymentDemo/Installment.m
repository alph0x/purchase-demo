//
//  Installment.m
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import "Installment.h"

@implementation Installment

+ (instancetype)instanceFromDictionary:(NSDictionary *)dictionary {
    if (!dictionary) return nil;
    
    Installment *installment = [Installment new];
    installment.number = [NSNumber numberWithUnsignedInteger:[[dictionary objectForKey:@"installments"] unsignedIntegerValue]];
    installment.rate = [NSNumber numberWithUnsignedInteger:[[dictionary objectForKey:@"installment_rate"] unsignedIntegerValue]];
    installment.discountRate = [NSNumber numberWithUnsignedInteger:[[dictionary objectForKey:@"discount_rate"] unsignedIntegerValue]];
    installment.labels = [dictionary objectForKey:@"labels"];
    installment.rateCollector = [[dictionary objectForKey:@"installment_rate_collector"] firstObject];
    installment.recommendedMessage = [dictionary objectForKey:@"recommended_message"];
    installment.amount = [Amount new];
    if (![[dictionary objectForKey:@"installment_amount"] isKindOfClass:[NSNull class]]) {
        installment.amount.raw = [NSNumber numberWithDouble:[[dictionary objectForKey:@"installment_amount"] doubleValue]];
    }
    installment.totalAmount = [Amount new];
    if (![[dictionary objectForKey:@"total_amount"] isKindOfClass:[NSNull class]]) {
        installment.totalAmount.raw = [NSNumber numberWithDouble:[[dictionary objectForKey:@"total_amount"] doubleValue]];
    }
    
    return installment;
}

@end
