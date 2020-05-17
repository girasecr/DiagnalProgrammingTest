# DiagnalProgrammingTest

# Tools and Langauge 
Xcode 11.3.1, 
Swift 5.0

# iOS Support
iPhone, iPad and supports iOS 13 to iOS latest OS version

# Architecture
Used MVVM Architecture

# Api classes
Used Request Manager Class to retive data from API page data using bundle

# Test Cases
Added Unit test cases.

# Used Terms
1. Used Collectionview to show three column data with vertical scroll.
2. Managed its size from collectionview delegate flow layout and from storyboard.

# Followed Programing Test Rules
- Create mobile version of content Listing page shown in Exports folder using native iOS Development Tools.

- This listing page contains a page title and a three column vertically scrolling grid which is not horizontally scrollable

- Redline folder details sizes for mobile app. Adapt this to iOS device form factors as necessary - Please note that the Redlines are based on 1080x1920 screen resolution 

- If anything is not specified in the Redline, make a best estimate on placing and sizing based on the Export folder images

- Slices folder has image assets which should all be used for this test. This includes poster images which are referred to in the JSON below. Note the images shown in the Exports folder are not the one to be used. The correct images are in the Slices folder.

- API folder has PAGEAPI-PAGE(#NUM).json which is used to provide data for the page (including specifying titles and poster images to be displayed). You will need to retrieve the data, JSON page at a time as the user scrolls down the page. Do not fetch all JSON pages at once, they should be loaded as the user navigates and approaches the end of their current data set. This lazy loading should be done in a seamless way without user noticing that additional data is loading (no pausing of scroll)

- Two content items on Page 3 have edge cases which you will need to think creatively how to solve without breaking the UI consistency

- The final package should contain the source code along with the signed IPA. Bonus marks for distributing it as a Hosted IPA or via platforms like TestFlight, Crashlytics Beta or HockeyApp

- Write some release notes to go in the zip if you feel you need to explain any features (technical or not) or known issues

- Think about usability and ensure as close a match to the design as possible

- Use UI component / frameworks that you think are going to help speed up development but also perform well

- Write code that is easy to understand 

- Demonstrate your ability to write maintainable code

- Bonus marks for following TDD and writing associated unit cases. 

