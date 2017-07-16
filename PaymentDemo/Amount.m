//
//  Amount.m
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import "Amount.h"

@implementation Amount

- (void) removeDigit {
    
    if (self.raw.doubleValue == 0) {
        self.raw = @0;
        return;
    }
    
    NSString *amount = [NSString stringWithFormat:@"%.02f", self.raw.doubleValue];
    
    if (![amount containsString:@"."]) { //It means is integer, we need a decimal.
        amount = [NSString stringWithFormat:@"%@.00", amount];
        
    }else if (amount.length == 2 && [amount containsString:@"."]) { //It means that only have one decimal, we need 2.
        amount = [NSString stringWithFormat:@"%@0", amount];
    }
    
    amount = [amount stringByReplacingOccurrencesOfString:@"." withString:@""];
    amount = [amount substringToIndex:amount.length - 1];
    
    amount = [self getStringNumberWithFormattedDecimalFromString:amount];
    
    self.raw = [NSNumber numberWithDouble:amount.doubleValue];
    
}

- (void) addDigit:(NSString *) digit {
    NSString *amount = [NSString stringWithFormat:@"%.02f", self.raw.doubleValue];
    
    if (![amount containsString:@"."]) { //It means is integer, we need a decimal.
        amount = [NSString stringWithFormat:@"%@.00", amount];
        
        
    }else if (amount.length == 2 && [amount containsString:@"."]) { //It means that only have one decimal, we need 2.
        amount = [NSString stringWithFormat:@"%@0", amount];
    }
    
    
    amount = [NSString stringWithFormat:@"%@%@", amount, digit];
    amount = [amount stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    if (amount.doubleValue == 0) {
        return;
    }
    
    amount = [self getStringNumberWithFormattedDecimalFromString:amount];
    
    if (amount.doubleValue > 10000000) {
        return;
    }
    
    
    self.raw = [NSNumber numberWithDouble:amount.doubleValue];
    
}

- (NSString *) getFormattedAmount {
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyAccountingStyle];
    [numberFormatter setLocale:[NSLocale currentLocale]];
    
    return [numberFormatter stringFromNumber:self.raw];
    
}

- (NSString *) getStringNumberWithFormattedDecimalFromString:(NSString *) string {
    
    NSString *amount = string;
    
    if (amount.length > 2) {
        NSString *nonDecimal = [amount substringToIndex:amount.length - 2];
        NSString *decimal = [amount substringFromIndex:amount.length - 2];
        amount = [NSString stringWithFormat:@"%@.%@", nonDecimal, decimal];
    }else if (amount.length == 1) {
        amount = [NSString stringWithFormat:@"0.0%@", amount];
    }else {
        amount = [NSString stringWithFormat:@"0.%@", amount];
    }
    
    return amount;
    
}

@end

