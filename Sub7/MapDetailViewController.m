//
//  MapDetailViewController.m
//  Sub7
//
//  Created by Clint Chilcott on 2/10/15.
//  Copyright (c) 2015 Clint Chilcott. All rights reserved.
//
//   Map is laid out - Transfer Parse Data
//
//
//

#import "MapDetailViewController.h"
#import <MapKit/MapKit.h>
#import "Shop.h"

@interface MapDetailViewController () <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.mapView.delegate = self;
    [self.mapView setShowsUserLocation:YES];

    self.mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    self.mapView.mapType = MKMapTypeHybrid;


    MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
    annotation.title = @"Example Spot";
    annotation.coordinate = CLLocationCoordinate2DMake(37.7908, -122.4020);
    [self.mapView addAnnotation:annotation];

}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];

    pin.canShowCallout = YES;
    pin.image = [UIImage imageNamed:@""];
    return pin;
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //Get Coordiantes
    CLLocationCoordinate2D myLocation = [userLocation coordinate];

    //Zoom Into Location On Map
    MKCoordinateRegion zoomRegion = MKCoordinateRegionMakeWithDistance(myLocation, 0.10, 0.10);

    //Show Location
    [self.mapView setRegion:zoomRegion animated:YES];
}

//GeoFence Method




@end
