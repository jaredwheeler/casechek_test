# Casechek code challenge

### Build/run requirements:
Requires XCode 10 and the iOS simulator to build/run.  Open the CasechekTest.xcodeproj project file in XCode, select an appropriate iOS simulator from the acive scheme drop-down, and click the run button.

### Overview:
I'm presenting this solution as a native iOS Swift 4 codebase, in light of the requirements noted for your next mobile app:
- On-device media access
- Computer Vision library implementations (ORC/Barcode scanning)
- Widely varying network environment/quality of service

Given the limited scope of a code challenge, many architectural decisions presented here wouldn't hold up to production use cases.  A real world app would exhibit greater concern for the following:
- Network stack tolerance for variance in quality of service
- Background data transfer
- Design of local cache sync/eviction policies 
- UI layout which scales across screen sizes
- UI stack architecture to handle deep-linking (create and view shareable links which can be sent via various comms platforms)


### Further detail:
Throat-clearing out of the way, the following is a more detailed description of how this submission functions.

Upon first launch, a request is made against the API. That JSON data is parsed and converted into a local iOS object graph (CoreData), which is backed by a SQLite persistent store on the device's SSD.  This is clearly unnecessary for the scope of this code challenge, but I wanted to demonstrate familiarity with the various aspects of device-level caching architectures.

The UI stack is a standard iOS component system (SplitView) consisting of a table view and a detail view.  This was chosen since it automatically adapts to the various screen sizes available in the iOS ecosystem.  

The SplitView also has the benefit of compatibility with a standard iOS data-store-to-view pipeline called a FetchedResultsController.  It requires a fair amount of boilerplate code, (as you may have noticed) but it brings in a lot of automatic view binding behavior.  It's well-suited to a code challenge, but its strong opinion about view stack architecture makes it a tougher call in a real-world app.

I've included a unit test as an example.  It exercises the ISO8601 date formatter I've set up to parse the inspection date string from JSON.  In it, individual strings are created for each field (year, month, day, etc.) in the final date string.  A date is created from a concatenation of those fields.  The fields in that created date are then tested for integer equality against the initial string date fields.  See CasechekTestTests.swift.