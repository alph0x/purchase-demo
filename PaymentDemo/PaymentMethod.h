//
//  PaymentMethod.h
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    paymentMethodStatusInactive = 0,
    paymentMethodStatusActive = 1
} paymentMethodStatus;

typedef enum {
    deferredCaptureNotApply = 0,
    deferredCaptureUnsupported = 1,
    deferredCaptureSupported = 2
} deferredCapture;

typedef enum {
    securityCodeModeOptional = 0,
    securityCodeModeMandatory = 1
    
} securityCodeMode;

typedef enum {
    securityCodeLocationBack = 0,
    securityCodeLocationFront = 1
    
} securityCodeLocation;

@interface Bin : NSObject

@property (strong, nonatomic) NSString *pattern;
@property (strong, nonatomic) NSString *exclusionPattern;
@property (strong, nonatomic) NSString *installmentsPattern;

+ (instancetype) instanceWithDictionary:(NSDictionary *) dictionary;

@end

@interface CardNumber : NSObject

@property (strong, nonatomic) NSNumber *length;
@property (strong, nonatomic) NSString *validation;

+ (instancetype) instanceWithDictionary:(NSDictionary *) dictionary;

@end

@interface SecurityCode : NSObject

@property securityCodeMode mode;
@property (strong, nonatomic) NSNumber *length;
@property securityCodeLocation codeLocation;

+ (instancetype) instanceWithDictionary:(NSDictionary *) dictionary;

@end

@interface Settings : NSObject

@property (strong, nonatomic) Bin *bin;
@property (strong, nonatomic) CardNumber *cardNumber;
@property (strong, nonatomic) SecurityCode *securityCode;

+ (instancetype) instanceWithDictionary:(NSDictionary *) dictionary;

@end

@interface PaymentMethod : NSObject

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *paymentTypeIdentifier;
@property paymentMethodStatus status;
@property (strong, nonatomic) NSURL *secureThumbnail;
@property (strong, nonatomic) NSURL *thumbnail;
@property deferredCapture deferredCapture;
@property (strong, nonatomic) Settings *settings;
@property (strong, nonatomic) NSArray *additionalInfoNeeded;
@property (strong, nonatomic) NSNumber *minAllowedAmount;
@property (strong, nonatomic) NSNumber *maxAllowedAmount;
@property (strong, nonatomic) NSNumber *accreditationTime;
@property (strong, nonatomic) NSArray *financialInstitutions;

+ (instancetype) instanceWithDictionary:(NSDictionary *) dictionary;

@end
