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


@interface DetailViewController ()<CLLocationManagerDelegate, MKMapViewDelegate, MKOverlay>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property CLLocationManager *locationManager;
@property MKPointAnnotation *sandwichAnnotation;
@property (weak, nonatomic) IBOutlet UIView *labelsView;
@property CGRect originalFrame;
@property UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UILabel *travelTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *subShopLabel;
@property (weak, nonatomic) IBOutlet UILabel *subShopAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subPriceLabel;
@property BOOL mapTapped;
@property (weak, nonatomic) IBOutlet UIButton *callButton;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displaySubImage];
    self.locationManager = [CLLocationManager new];
    self.mapView.showsUserLocation = true;
    self.sandwichAnnotation = [MKPointAnnotation new];
    CLLocation *shopLocation = [[CLLocation alloc]initWithLatitude:self.selectedSub.shop.location.latitude longitude:self.selectedSub.shop.location.longitude];
    self.sandwichAnnotation.coordinate = shopLocation.coordinate;
    [self.mapView addAnnotation:self.sandwichAnnotation];
    [self getDirections];
    [self.mapView showAnnotations: self.mapView.annotations animated:YES];
    
    
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
    //    [sourceMapItem setName:@""];
    MKPlacemark *destination = [[MKPlacemark alloc]initWithCoordinate:self.sandwichAnnotation.coordinate addressDictionary:nil];
    MKMapItem *destinationMapItem = [[MKMapItem alloc]initWithPlacemark:destination];
    //    [destinationMapItem setName:@""];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    [request setSource:sourceMapItem];
    [request setDestination:destinationMapItem];
    [request setTransportType:MKDirectionsTransportTypeWalking];
    MKDirections *directions = [[MKDirections alloc]initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        
        NSLog(@"response = %@",response);
        NSArray *routeDirections = [response routes];
        [routeDirections enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
            
            MKRoute *route = object;
            
            MKPolyline *line = [route polyline];
            [self.mapView addOverlay:line];
            self.travelTimeLabel.text = [NSString stringWithFormat:@"%.0f min",(route.expectedTravelTime/60)];
            
            NSArray *steps = [route steps];
            
            NSLog(@"Total Steps : %lu",(unsigned long)[steps count]);
            [steps enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
                NSLog(@"Route Instruction : %@",[object instructions]);
                NSLog(@"Route Distance : %f",[object distance]);
            }];
        }];
    }];
}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineView* aView = [[MKPolylineView alloc]initWithPolyline:(MKPolyline*)overlay] ;
        aView.strokeColor = [[UIColor colorWithRed:255/255.0 green:104/255.0 blue:57/255.0 alpha:1.0] colorWithAlphaComponent:0.5];
        aView.lineWidth = 10;
        return aView;
    }
    return nil;
}


- (IBAction)mapViewTapped:(UITapGestureRecognizer *)gesture {
    
        CGPoint touchPoint = [gesture locationInView:self.view];
        self.originalFrame = CGRectMake(self.mapView.frame.origin.x, self.mapView.frame.origin.y, self.mapView.frame.size.width, self.mapView.frame.size.height);
        CGRect newFrame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        if (CGRectContainsPoint(self.mapView.frame, touchPoint)) {
            [self.navigationItem setHidesBackButton:true];
            self.labelsView.hidden = true;
            [UIView animateWithDuration:0.4 animations:^{
                self.mapView.frame = newFrame;

            }];
            self.doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(restoreOriginalView)];
            self.navigationItem.rightBarButtonItem = self.doneButton;
            [self.mapView showAnnotations: self.mapView.annotations animated:YES];
        }
    
    
}


-(void)restoreOriginalView {
    self.doneButton.title = @"";
    self.doneButton.enabled = false;
    self.mapView.frame = self.originalFrame;
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
    [self.navigationItem setHidesBackButton:false];
    self.labelsView.hidden = false;
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


@end
