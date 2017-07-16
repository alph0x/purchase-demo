//
//  Bank.h
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bank : NSObject

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSURL *secureThumbnail;
@property (strong, nonatomic) NSURL *thumbnail;
@property (strong, nonatomic) NSString *processingMode;
@property (strong, nonatomic) NSString *merchantAccountIdentifier;

+ (instancetype) instanceWithDictionary:(NSDictionary *) dictionary;

@end
