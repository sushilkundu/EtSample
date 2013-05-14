//
//  NewsItem.h
//  EtSample
//
//  Created by Sushil Kundu on 19/04/13.
//  Copyright (c) 2013 Sushil Kundu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject

@property (strong,nonatomic) NSString *headLine;
@property (strong,nonatomic) NSString *newsItemId;
@property (strong,nonatomic) NSString *dateLine;
@property (strong,nonatomic) NSString *webURL;
@property (strong,nonatomic) NSString *photoURL;
@property (strong,nonatomic) NSString *thumbURL;
@property (strong,nonatomic) NSString *photoCaption;
@property (strong,nonatomic) NSString *agency;
@property (strong,nonatomic) NSString *story;


@end
