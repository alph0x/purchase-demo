//
//  PaymentMethod.m
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import "PaymentMethod.h"

@implementation PaymentMethod

+ (instancetype)instanceWithDictionary:(NSDictionary *)dictionary {
    
    if (!dictionary) return nil;
    
    PaymentMethod *paymentMethod = [PaymentMethod new];
    paymentMethod.identifier = [dictionary objectForKey:@"id"];
    paymentMethod.name = [dictionary objectForKey:@"name"];
    paymentMethod.paymentTypeIdentifier = [dictionary objectForKey:@"payment_type_id"];
    paymentMethod.status = [self getStatusFromDictionary:dictionary];
    paymentMethod.secureThumbnail = [NSURL URLWithString:[dictionary objectForKey:@"secure_thumbnail"]];
    paymentMethod.thumbnail = [NSURL URLWithString:[dictionary objectForKey:@"thumbnail"]];
    paymentMethod.deferredCapture = [self getDeferredCaptureFromDictionary:dictionary];
        paymentMethod.settings = [Settings instanceWithDictionary:[[dictionary objectForKey:@"settings"] firstObject]];
    paymentMethod.additionalInfoNeeded = [dictionary objectForKey:@"additional_info_needed"];
    paymentMethod.minAllowedAmount = [NSNumber numberWithUnsignedInteger:[[dictionary objectForKey:@"min_allowed_amount"] unsignedIntegerValue]];
    paymentMethod.maxAllowedAmount = [NSNumber numberWithUnsignedInteger:[[dictionary objectForKey:@"max_allowed_amount"] unsignedIntegerValue]];
    paymentMethod.accreditationTime = [NSNumber numberWithUnsignedInteger:[[dictionary objectForKey:@"accreditation_time"] unsignedIntegerValue]];
    paymentMethod.financialInstitutions = [dictionary objectForKey:@"financial_institutions"];
    
    return paymentMethod;
}

+ (paymentMethodStatus) getStatusFromDictionary:(NSDictionary *) dictionary {
    paymentMethodStatus status = paymentMethodStatusInactive;
    if ([[dictionary objectForKey:@"status"] isEqualToString:@"active"]) {
        status = paymentMethodStatusActive;
    }
    
    return status;
}

+ (deferredCapture) getDeferredCaptureFromDictionary:(NSDictionary *) dictionary {
    deferredCapture deferredCapture = deferredCaptureUnsupported;
    if ([[dictionary objectForKey:@"deferred_capture"] isEqualToString:@"supported"]) {
        deferredCapture = deferredCaptureSupported;
    }
    if ([[dictionary objectForKey:@"deferred_capture"] isEqualToString:@"does_not_apply"]) {
        deferredCapture = deferredCaptureNotApply;
    }
    
    return deferredCapture;
}

@end

@implementation Settings

+ (instancetype)instanceWithDictionary:(NSDictionary *)dictionary {
    
    if (!dictionary) return nil;
    
    Settings *settings = [Settings new];
    settings.bin = [Bin instanceWithDictionary:[dictionary objectForKey:@"bin"]];
    settings.cardNumber = [CardNumber instanceWithDictionary:[dictionary objectForKey:@"card_number"]];
    settings.securityCode = [SecurityCode instanceWithDictionary:[dictionary objectForKey:@"security_code"]];
    
    return settings;
}

@end

@implementation Bin

+ (instancetype)instanceWithDictionary:(NSDictionary *)dictionary {
    
    if (!dictionary) return nil;
    
    Bin *bin = [Bin new];
    bin.pattern = [dictionary objectForKey:@"pattern"];
    bin.exclusionPattern = [dictionary objectForKey:@"exclusion_pattern"];
    bin.installmentsPattern = [dictionary objectForKey:@"installments_pattern"];
    
    return bin;
}

@end

@implementation CardNumber

+ (instancetype)instanceWithDictionary:(NSDictionary *)dictionary {
    
    if (!dictionary) return nil;
    
    CardNumber *cardNumber = [CardNumber new];
    cardNumber.length = [NSNumber numberWithUnsignedInteger:[[dictionary objectForKey:@"length"] unsignedIntegerValue]];
    cardNumber.validation = [dictionary objectForKey:@"validation"];
    
    return cardNumber;
}

@end

@implementation SecurityCode

+ (instancetype)instanceWithDictionary:(NSDictionary *)dictionary {
    
    if (!dictionary) return nil;
    
    SecurityCode *securityCode = [SecurityCode new];
    securityCode.mode = [self getSecurityCodeModeFromDictionary:dictionary];
    securityCode.length = [NSNumber numberWithUnsignedInteger:[[dictionary objectForKey:@"length"] unsignedIntegerValue]];
    securityCode.codeLocation = [self getSecurityCodeLocationFromDictionary:dictionary];
    return securityCode;
}

+ (securityCodeMode) getSecurityCodeModeFromDictionary:(NSDictionary *) dictionary {
    securityCodeMode securityCodeMode = securityCodeModeOptional;
    if ([[dictionary objectForKey:@"mode"] isEqualToString:@"mandatory"]) {
        securityCodeMode = securityCodeModeMandatory;
    }
    
    return securityCodeMode;
}

+ (securityCodeLocation) getSecurityCodeLocationFromDictionary:(NSDictionary *) dictionary {
    securityCodeLocation securityCodeLocation = securityCodeLocationFront;
    if ([[dictionary objectForKey:@"card_location"] isEqualToString:@"back"]) {
        securityCodeLocation = securityCodeLocationBack;
    }
    
    return securityCodeLocation;
}

@end
