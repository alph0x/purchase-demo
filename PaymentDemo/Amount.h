//
//  Amount.h
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Amount : NSObject

@property (strong, nonatomic) NSNumber *raw;

- (void) removeDigit;
- (void) addDigit:(NSString *) digit;
- (NSString *) getFormattedAmount;

@end
