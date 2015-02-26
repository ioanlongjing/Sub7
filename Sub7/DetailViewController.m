                //
//  DetailViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/10/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//

#import "DetailViewController.h"
#import <MapKit/MapKit.h>
#import "PhoneNumberFormatter.h"
#import "MapViewController.h"


@interface DetailViewController ()<CLLocationManagerDelegate, MKMapViewDelegate, MKOverlay>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property CLLocationManager *locationManager;
@property MKPointAnnotation *sandwichAnnotation;
@property (weak, nonatomic) IBOutlet UILabel *travelTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *subShopLabel;
@property (weak, nonatomic) IBOutlet UILabel *subShopAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subPriceLabel;
@property BOOL mapTapped;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property MKRoute *route;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self displaySubImage];
    self.locationManager = [CLLocationManager new];
    self.route = [MKRoute new];
    self.locationManager.delegate = self;
    self.mapView.showsUserLocation = true;
    self.sandwichAnnotation = [MKPointAnnotation new];
    CLLocation *shopLocation = [[CLLocation alloc]initWithLatitude:self.selectedSub.shop.location.latitude longitude:self.selectedSub.shop.location.longitude];
    self.sandwichAnnotation.coordinate = shopLocation.coordinate;
    [self.mapView addAnnotation:self.sandwichAnnotation];
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
    [self getDirections];
}


- (void)viewWillAppear:(BOOL)animated
{
    
    Shop *selectedShop = [Shop new];
    selectedShop = self.selectedSub.shop;
    
    self.subShopLabel.text = selectedShop.name;
    self.subShopAddressLabel.text = selectedShop.address;
    
    self.subNameLabel.text = [NSString stringWithFormat:@"%@", self.selectedSub.name];
    self.subPriceLabel.text = [NSString stringWithFormat:@"$%.02f",[self.selectedSub.price floatValue]];;
    
    // set title of call button to "Call (555) 415-5392"
    PhoneNumberFormatter *formatter = [[PhoneNumberFormatter alloc] init];
    NSString *phoneInFormat = [formatter format:self.selectedSub.shop.phone withLocale:@"us"];
    [self.callButton setTitle:[NSString stringWithFormat:@"Call %@", phoneInFormat] forState:UIControlStateNormal];
    
    
}

-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
    
    if (annotation == self.sandwichAnnotation) {
        pin.image = [UIImage imageNamed:@"pin"];
        pin.canShowCallout = YES;
        pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        return pin;
    }
    else {
        return nil;
    }
}


-(void) getDirections {
    CLLocation *currentLocation = [[CLLocation alloc]initWithLatitude:self.currentLocation.latitude longitude:self.currentLocation.longitude];
    MKPlacemark *source = [[MKPlacemark alloc]initWithCoordinate:currentLocation.coordinate addressDictionary:nil];
    MKMapItem *sourceMapItem = [[MKMapItem alloc]initWithPlacemark:source];
    MKPlacemark *destination = [[MKPlacemark alloc]initWithCoordinate:self.sandwichAnnotation.coordinate addressDictionary:nil];
    MKMapItem *destinationMapItem = [[MKMapItem alloc]initWithPlacemark:destination];
    [destinationMapItem setName:[NSString stringWithFormat:@"%@", self.selectedSub.shop.name]];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    [request setSource:sourceMapItem];
    [request setDestination:destinationMapItem];
    [request setTransportType:MKDirectionsTransportTypeWalking];
    MKDirections *directions = [[MKDirections alloc]initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        NSArray *routeDirections = [response routes];
        [routeDirections enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
            
            self.route = object;
            

            self.travelTimeLabel.text = [NSString stringWithFormat:@"%.0f min",(self.route.expectedTravelTime/60)];
            
            
        }];
    }];
}



- (IBAction)mapViewTapped:(UITapGestureRecognizer *)gesture {
        CGPoint touchPoint = [gesture locationInView:self.view];
        if (CGRectContainsPoint(self.mapView.frame, touchPoint)) {
            [self performSegueWithIdentifier:@"MapDetailSeg" sender:self];
        }
    
    
}

- (IBAction)callButtonTapped:(UIButton *)button {
    NSString *phoneNumber = self.selectedSub.shop.phone;
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",phoneNumber]];
    if ([[UIApplication sharedApplication] canOpenURL:phoneURL]) {
        [[UIApplication sharedApplication] openURL:phoneURL];
    } else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Call failed" message:@"Sorry, an error occured in connecting you. Please try again." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
}


-(void) displaySubImage {
    NSData *data = [self.selectedSub.image getData];
    UIImage *image = [UIImage imageWithData:data];
    self.imageView.image = image;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MapViewController *mvc = segue.destinationViewController;
    mvc.subRoute = self.route;
    mvc.shopAnnotation = self.sandwichAnnotation;
    mvc.title = self.selectedSub.shop.name;
    
    
}

@end
