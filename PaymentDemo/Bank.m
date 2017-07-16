//
//  Bank.m
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import "Bank.h"

@implementation Bank

+ (instancetype) instanceWithDictionary:(NSDictionary *) dictionary {
    if (!dictionary) return nil;
    
    Bank *bank = [Bank new];
    
    bank.identifier = [dictionary objectForKey:@"id"];
    bank.name = [dictionary objectForKey:@"name"];
    bank.thumbnail = [NSURL URLWithString:[dictionary objectForKey:@"thumbnail"]];
    bank.secureThumbnail = [NSURL URLWithString:[dictionary objectForKey:@"secure_thumbnail"]];
    bank.processingMode = [dictionary objectForKey:@"processing_mode"];
//    bank.merchantAccountIdentifier = [dictionary objectForKey:@"merchant_account_id"];
    
    return bank;
}

@end
