//
//  ETViewController.m
//  EtSample
//
//  Created by Sushil Kundu on 19/04/13.
//  Copyright (c) 2013 Sushil Kundu. All rights reserved.
//

#import "ETViewController.h"
#import "AFNetworking.h"
#import "SectionObject.h"
#import "NewsItem.h"

@interface ETViewController ()

@property(strong,nonatomic) NSMutableArray *rootSectionDataArray;
@property(strong,nonatomic) NSMutableDictionary *subSectionDictionary;
@property(strong,nonatomic) NSMutableDictionary *sectionNewsDictionary;

@end

@implementation ETViewController
@synthesize rootSectionDataArray;
@synthesize subSectionDictionary;
@synthesize sectionNewsDictionary;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.subSectionDictionary = [[NSMutableDictionary alloc] init];
        self.sectionNewsDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURLRequest *_dataForSectionsRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://et86.indiatimes.com/dynamicfeed.cms?nav=root&cmsdataformat=json"]];
    AFJSONRequestOperation *_dataForSectionOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:_dataForSectionsRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
        NSDictionary *_jsonResponse = (NSDictionary *) JSON;
        NSDictionary *_itemArray = [_jsonResponse objectForKey:@"Item"];
        self.rootSectionDataArray = [[NSMutableArray alloc] init];
        for (NSDictionary *_item in _itemArray){
            SectionObject *_sectionObject = [[SectionObject alloc] init];
            [_sectionObject setName:[_item objectForKey:@"name"]];
            [_sectionObject setDefaultName:[_item objectForKey:@"defaultname"]];
            [_sectionObject setDefaultUrl:[[_item objectForKey:@"defaulturl"] stringByReplacingOccurrencesOfString:@"economictimes" withString:@"et86"]];
            [_sectionObject setSectionUrl:[[_item objectForKey:@"sectionurl"] stringByReplacingOccurrencesOfString:@"economictimes" withString:@"et86"]];
            [_sectionObject setSubSections:[_item objectForKey:@"subsections"]];
            if ([_sectionObject.subSections isEqualToString:@"yes"]) {
                [self loadSectionNames:[NSURL URLWithString:_sectionObject.sectionUrl] withSectionName:_sectionObject.name];
            }else{
                
            }
            [_sectionObject setTempalate:[_item objectForKey:@"template"]];
            [self.rootSectionDataArray addObject:_sectionObject];
        }
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        NSLog(@"error : %@",error);
    }];
    
    [_dataForSectionOperation start];
    // Do any additional setup after loading the view from its nib.
}


- (void)loadSectionNames:(NSURL *)aURL withSectionName:(NSString *)aSectionName{
    NSURLRequest *_dataForSectionsRequest = [NSURLRequest requestWithURL:aURL];
    AFJSONRequestOperation *_dataForSectionOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:_dataForSectionsRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
        NSDictionary *_jsonResponse = (NSDictionary *) JSON;
        NSDictionary *_itemArray = [_jsonResponse objectForKey:@"Item"];
        for (NSDictionary *_item in _itemArray){
            SectionObject *_sectionObject = [[SectionObject alloc] init];
            [_sectionObject setName:[_item objectForKey:@"name"]];
            [_sectionObject setDefaultName:[_item objectForKey:@"defaultname"]];
            [_sectionObject setDefaultUrl:[[_item objectForKey:@"defaulturl"] stringByReplacingOccurrencesOfString:@"economictimes" withString:@"et86"]];
            [_sectionObject setSectionUrl:[[_item objectForKey:@"sectionurl"] stringByReplacingOccurrencesOfString:@"economictimes" withString:@"et86"]];
            [_sectionObject setSubSections:[_item objectForKey:@"subsections"]];
            [_sectionObject setTempalate:[_item objectForKey:@"template"]];
            [self.subSectionDictionary setObject:_sectionObject forKey:aSectionName];
            if ([_sectionObject.subSections isEqualToString:@"yes"]) {
                [self loadSectionNames:[NSURL URLWithString:_sectionObject.sectionUrl] withSectionName:_sectionObject.name];
            }else{
                
            }
        }
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        NSLog(@"error : %@",error);
    }];
    
    [_dataForSectionOperation start];
}


-(void)loadNewsForSection:(NSURL *)aURL withSectionName:(NSString *)aSectionName{
    NSURLRequest *_dataForSectionsRequest = [NSURLRequest requestWithURL:aURL];
    AFJSONRequestOperation *_dataForSectionOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:_dataForSectionsRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
        NSDictionary *_jsonResponse = (NSDictionary *) JSON;
        NSDictionary *_itemArray = [_jsonResponse objectForKey:@"Item"];
        NSMutableArray *_newsArray = [[NSMutableArray alloc] init];
        for (NSDictionary *_item in _itemArray){
            NewsItem *_newsObject = [[NewsItem alloc] init];
//            [_newsObject setName:[_item objectForKey:@"name"]];
//            [_newsObject setDefaultName:[_item objectForKey:@"defaultname"]];
//            [_newsObject setDefaultUrl:[[_item objectForKey:@"defaulturl"] stringByReplacingOccurrencesOfString:@"economictimes" withString:@"et86"]];
//            [_newsObject setSectionUrl:[[_item objectForKey:@"sectionurl"] stringByReplacingOccurrencesOfString:@"economictimes" withString:@"et86"]];
//            [_newsObject setSubSections:[_item objectForKey:@"subsections"]];
         
        }
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        NSLog(@"error : %@",error);
    }];
    
    [_dataForSectionOperation start];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
