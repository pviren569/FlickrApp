**Flickr Search App**

**Overview**

Flickr Search App is an iOS application that allows users to search for images from Flickr using a public API. The app fetches and displays images in a grid view, and users can tap on an image to view more details, including the title, author, publication date, and description.

**Features**

- **Image Search:** Users can search for images using keywords.
- **Grid View Display:** Results are displayed in a grid layout with thumbnails.
- **Detail View:** Tapping an image shows more details about the photo.
- **HTML Description Parsing:** Displays formatted descriptions from Flickr.
- **Caching:** Image caching for better performance.
- **Accessibility Support:** VoiceOver support.
- **Unit Tests:** Includes unit tests for the ViewModel and API service.

**Technologies Used**

- **SwiftUI** for UI components.
- **MVVM Architecture** for better separation of concerns.
- **URLSession** for network requests.
- **NSCache** for image caching.
- **AttributedString** for parsing and displaying HTML content.
- **XCTest** for unit testing.

**Installation**

1. Clone the repository:
   ```bash
   git clone https://github.com/pviren569/FlickrApp.git
   ```
2. Open the project in Xcode:
   ```bash
   cd FlickrApp
   open FlickrApp.xcodeproj
   ```
3. Run the app on a simulator.

**Usage**

1. Enter a keyword in the search bar to fetch images from Flickr.
2. Tap on any image to view its details.
4. Use VoiceOver for accessibility testing.

**Unit Testing**

To run unit tests, open **Xcode** and go to:

- **Product** > **Test** or press `Cmd + U`
- This will execute the test case

**Demo**

<video width="600" controls>
  <source src="https://github.com/pviren569/FlickrApp/blob/main/Demo.mp4">
</video>

