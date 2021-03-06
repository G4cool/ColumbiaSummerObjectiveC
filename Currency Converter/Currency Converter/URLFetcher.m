//
//  URLFetcher.m
//  Currency Converter
//
//  Created by Luca on 7/13/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import "URLFetcher.h"
#import "ExchangeRate.h"

static NSDictionary* dataHereAgain = nil;

@implementation URLFetcher

@synthesize completionHandlerDictionary;
@synthesize ephemeralConfigObject;
//@synthesize dataHere;

-(URLFetcher*) init {
    self = [super init];
    if(self){
        completionHandlerDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
        ephemeralConfigObject = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    }
    return self;
}

+ (NSDictionary*) data {
    return dataHereAgain;
}

-(void) fetch {
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: self.ephemeralConfigObject delegate: nil delegateQueue: mainQueue];
    for(ExchangeRate* i in [ExchangeRate allExchangeRates]) { // Fix this, the way it is implemented now, we do not need the loop, but there are still references to it, like i in [i description] and [i exchangeRateURL]
        NSLog(@"dispatching %@", [i description]);
        NSURLSessionTask* task = [delegateFreeSession dataTaskWithURL: [i exchangeRateURL]
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        //NSLog(@"Got response %@ with error %@.\n", response, error);
                                                        id obj = [NSJSONSerialization JSONObjectWithData: data
                                                                                                 options: 0
                                                                                                   error: nil];
                                                        //NSLog(@"Rate value from URLFetcher.m: %@", obj[@"Rate"]);
                                                        if ([obj isKindOfClass: [NSDictionary class]]) {
                                                            NSDictionary *dict = (NSDictionary*)obj;
                                                            //NSLog(@"Rate value from URLFetcher.m: %@", dict[@"Rate"]);
                                                            //NSLog(@"%@", [dict description]);
                                                            dataToTransfer = [dict description];
                                                            self.dataHere = dataToTransfer;
                                                            dataHereAgain = dict;
                                                        } else {
                                                            NSLog(@"Not a dictionary.");
                                                            exit(1);
                                                        }
                                                    }];
        [task resume];
    }
}

@end















