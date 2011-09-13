//
//  SecondViewController.m
//  TabBarDemo
//
//  Created by Chang Ming-Long on 11/8/27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"
#import "McdStore.h"

@implementation SecondViewController

@synthesize urlConnection;
@synthesize receivedData;
@synthesize mcdStores;
@synthesize xmlParser;
@synthesize mcdStoreController;
@synthesize showAllStore, showOnlyDtStore;

@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

- (NSFetchedResultsController *) fetchedResultsController {
<<<<<<< HEAD

	if (!__fetchedResultsController) {
		
		__fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:((^ {
		
			NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
			fetchRequest.entity = [NSEntityDescription entityForName:@"Store" inManagedObjectContext:self.managedObjectContext];
			fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
			return fetchRequest;
			
		})()) managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
		
	}
	
	return __fetchedResultsController;

}

- (NSManagedObjectContext *) managedObjectContext {

	if (!__managedObjectContext) {
	
		__managedObjectContext = [[NSManagedObjectContext alloc] init];
		
		[__managedObjectContext setPersistentStoreCoordinator:((^ {
		
			NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TabBarDemo" withExtension:@"momd"];
			NSManagedObjectModel *model = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] autorelease];
=======
    
	if (!__fetchedResultsController) {
        
		__fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:((^ {
            
			NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
			fetchRequest.entity = [NSEntityDescription entityForName:@"CdMcdStore" inManagedObjectContext:self.managedObjectContext];
			fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
			return fetchRequest;
            
		})()) managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        
	}
    
	return __fetchedResultsController;
    
}

- (NSManagedObjectContext *) managedObjectContext {
    
	if (!__managedObjectContext) {
        
		__managedObjectContext = [[NSManagedObjectContext alloc] init];
        
		[__managedObjectContext setPersistentStoreCoordinator:((^ {
            
			NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TabBarDemo" withExtension:@"momd"];
			NSManagedObjectModel *model = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] autorelease];
            
>>>>>>> add Core Data, save store information
			NSPersistentStoreCoordinator *coordinator = [[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model] autorelease];
			NSString *documentsPath = [[NSSet setWithArray:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)] anyObject];
			NSString *storePath = [[documentsPath stringByAppendingPathComponent:@"DataStore"] stringByAppendingPathExtension:@"sqlite"];
			NSURL *storeURL = [NSURL fileURLWithPath:storePath];
			NSError *addingError = nil;
			if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&addingError])
				NSLog(@"Error adding persistent store: %@", addingError);
<<<<<<< HEAD
			
			return coordinator;
		
		})())];
	
	}
	
	return __managedObjectContext;

}

- (void) saveData
=======
            
			return coordinator;
            
		})())];
        
	}
    
	return __managedObjectContext;
    
}

- (void) saveData: (McdStore *)store
>>>>>>> add Core Data, save store information
{
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"CdMcdStore" inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newManagedObject setValue:store.title forKey:@"title"];
    [newManagedObject setValue:store.drivethrought forKey:@"drivethrought"];
    [newManagedObject setValue:store.opentime forKey:@"opentime"];
    [newManagedObject setValue:store.address forKey:@"address"];

    [newManagedObject setValue:[NSNumber numberWithDouble:[store.latitude doubleValue]] forKey:@"latitude"];
    [newManagedObject setValue:[NSNumber numberWithDouble:[store.longitude doubleValue]] forKey:@"longitude"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    //NSLog(@"CdSave");
}

-(IBAction) showAll:(id) sender
{
    [mapView removeAnnotations:mapView.annotations];
    for (McdStore *store in mcdStores) {
        [mapView addAnnotation:store];
    }    
}

-(IBAction) showDt:(id) sender
{

    [mapView removeAnnotations:mapView.annotations];

    //use core data
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CdMcdStore" inManagedObjectContext:self.managedObjectContext];
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    [fetchRequest setEntity:entity];
    // Set example predicate and sort orderings...
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(drivethrought = %@)", @"24小時得來速"];
    [fetchRequest setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"title" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [sortDescriptor release];    
    
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:fetchRequest error:&error];
    //NSLog(@"%@", array);
    if (array == nil)
    {
        // Deal with error...
        NSLog(@"Fetched error");
    }
    for (McdStore *item in array) {
        
        McdStore *mcdItem = [[McdStore alloc] init];
        CLLocationCoordinate2D mylocation;
        mylocation.latitude = [item.latitude doubleValue];
        mylocation.longitude = [item.longitude doubleValue];
        mcdItem.title = item.title;
        mcdItem.address = item.address;
        mcdItem.opentime = item.opentime;
        mcdItem.coordinate = mylocation;
        NSLog(@"%@", mcdItem.title);
        
        [mapView addAnnotation:mcdItem];
        [mcdItem release];
    }
    
    [fetchRequest release];
}

-(void) gotoTaipei
{
    // 建立一個CLLocationCoordinate2D
    CLLocationCoordinate2D mylocation;
    mylocation.latitude = 25.044956;
    mylocation.longitude = 121.513387;
    
    // 建立一個region，待會要設定給MapView
    MKCoordinateRegion adcube;
    
    // 設定經緯度
    adcube.center = mylocation;
    
    // 設定縮放比例
    adcube.span.latitudeDelta = 0.005;
    adcube.span.longitudeDelta = 0.005;
    [mapView setRegion:adcube];
}
-(void) getMcdXML
{
    //NSLog(@"startSearch");
    // Change UI to loading state
    // Create the URL which would be 
    NSString *urlAsString = [NSString stringWithFormat:@"%@", @"http://www.mcdonalds.com.tw/api/map_xml.php" ];
    
    //NSLog(@"urlAsString: %@",urlAsString );
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlAsString]];
    // Create the NSURLConnection con object with the NSURLRequest req object
    // and make this MountainsEx01ViewController the delegate.
    urlConnection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    // Connection successful
    if (urlConnection) {
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        [data release];
    }
    // Bad news, connection failed.
    else
    {
        UIAlertView *alert = [
                              [UIAlertView alloc]
                              initWithTitle:NSLocalizedString(@"Error", @"Error")
                              message:NSLocalizedString(@"Error connecting to remote server", @"Error connecting to remote server")
                              delegate:self
                              cancelButtonTitle:NSLocalizedString(@"Bummer", @"Bummer")
                              otherButtonTitles:nil
                              ];
        [alert show];
        [alert release];
    }
    [req release];
}
#pragma mark - NSURLConnection Callbacks
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [connection release];
    self.receivedData = nil; 
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error"
                          message:[NSString stringWithFormat:@"Connection failed! Error - %@ (URL: %@)", [error localizedDescription],[[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]]
                          delegate:self
                          cancelButtonTitle:@"Bummer"
                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    // Change UI to active state
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Convert receivedData to NSString.
    NSString *receivedDataAsString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    // Trace receivedData
    //NSLog(@"connectionDidFinishLoading %@", receivedDataAsString);
    
    [receivedDataAsString release];
    
    xmlParser = [[NSXMLParser alloc] initWithData:receivedData];
    [xmlParser setDelegate:self];
	//Start parsing the XML file.
	BOOL success = [xmlParser parse];
	
	if(success)
		NSLog(@"No Errors");
	else
		NSLog(@"Error Error Error!!!");    
    
    // Connection resources release.
    [connection release];
    self.receivedData = nil;
}

#pragma mark - NSXMLParser Callbacks
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //NSLog(@"%s", __FUNCTION__);
    //Is a mountain_item node
    if ([elementName isEqualToString:@"location"])
    {
        McdStore *mcdItem = [[McdStore alloc] init];
        mcdItem.title = [attributeDict objectForKey:@"name"];
        mcdItem.subtitle = [attributeDict objectForKey:@"open"];
        mcdItem.latitude = [attributeDict objectForKey:@"lat"];
        mcdItem.longitude = [attributeDict objectForKey:@"lng"];
        mcdItem.address = [attributeDict objectForKey:@"address"];
        mcdItem.opentime = [attributeDict objectForKey:@"open"];
        mcdItem.drivethrought = [attributeDict objectForKey:@"drivethrough"];

        
        CLLocationCoordinate2D mylocation;
        mylocation.latitude = [mcdItem.latitude doubleValue];
        mylocation.longitude = [mcdItem.longitude doubleValue];
        
        mcdItem.coordinate = mylocation;
        
        [mapView addAnnotation:mcdItem];
        //[mcdStores addObject:mcdItem];
        //NSLog(@"%d", [mcdStores count]);

        [self saveData:mcdItem];
        
        [mcdItem release];
        mcdItem = nil;
    }
}
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];

    
    mcdStores = [[NSMutableArray alloc] init];
    
    mapView.delegate = self;
    
    locationManager = [[CLLocationManager alloc] init];
    //locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	[locationManager startUpdatingLocation];
    
	CLLocation *location = locationManager.location;
	
    // start off by default
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = location.coordinate.latitude;
    newRegion.center.longitude = location.coordinate.longitude;
    newRegion.span.latitudeDelta = 0.05;
    newRegion.span.longitudeDelta = 0.05;
	
    [locationManager stopUpdatingLocation];
    locationManager.delegate = nil;
    [locationManager release];
    
	//NSLog(@"show setup 1: %f %f", location.coordinate.latitude, location.coordinate.longitude);

    // 把region設定給MapView
    [mapView setRegion:newRegion animated:YES];
    
    //GET MCD STORE
    [self getMcdXML];

    //[self gotoTaipei];
    
    //Annotation

}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	//NSLog(@"welcome into the map view annotation");
	
	// if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        NSLog(@"annotation isKindOfClass");
        return nil;
    }
	// try to dequeue an existing pin view first
	static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
	MKPinAnnotationView* pinView = [[[MKPinAnnotationView alloc]
									 initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier] autorelease];
	pinView.animatesDrop=YES;
	pinView.canShowCallout=YES;
	pinView.pinColor = MKPinAnnotationColorRed;
	
	
	UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[rightButton setTitle:annotation.title forState:UIControlStateNormal];
    /*
	[rightButton addTarget:self
					action:@selector(showDetails:)
		  forControlEvents:UIControlEventTouchUpInside];
    */
	pinView.rightCalloutAccessoryView = rightButton;
	
	UIImageView *profileIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"m_logo_30.png"]];
	pinView.leftCalloutAccessoryView = profileIconView;
	[profileIconView release];
	
	//NSLog(@"%@", annotation.title);
	return pinView;
    
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {

    McdStore * store = view.annotation;
    
    McdStoreController *view2 = [[McdStoreController alloc] initWithNibName:@"McdStoreController" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:view2 animated:YES];

    //NSLog(@"%@", store.address);
    view2.title = store.title;
    view2.text2.text = store.address;
    view2.text1.text = store.opentime;

    //self.showDetailView.eventData = [[NSMutableArray alloc] initWithArray:tmpArray copyItems:YES];

    //[self.mcdStoreController.eventData release];
    [view2 release];
    
}
/*
-(IBAction)showDetails:(id)sender{
    //NSLog(@"Annotation Click");
    NSLog(@"%@", ((UIButton *)sender).tag);
    
    McdStoreController *view2 = [[McdStoreController alloc] initWithNibName:@"McdStoreController" bundle:[NSBundle mainBundle]];
    
    self.mcdStoreController = view2;
    [view2.navigationController setTitle:((UIButton*)sender).currentTitle];    
    
    [self.navigationController pushViewController:self.mcdStoreController animated:YES];
    
    //NSLog(@"%@", ((UIButton*)sender).currentTitle);
    self.mcdStoreController.label2.text = ((UIButton*)sender).currentTitle;

    [view2 release];
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [mapView release];
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
