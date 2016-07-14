//
//  URLFetcher.h
//  Currency Converter
//
//  Created by Luca on 7/13/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLFetcher : NSObject {
    NSString* dataToTransfer;
}

@property (strong) NSMutableDictionary *completionHandlerDictionary;
@property (strong) NSURLSessionConfiguration *ephemeralConfigObject;
@property (strong, nonatomic) NSString* dataHere;

-(URLFetcher*) init;
+(NSString*) data;
-(void) fetch;

@end
