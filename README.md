# Travel_Project_2022


Documentation of MakeMyTrip Project


==> MAKE MY TRIP

The Application is all about the service provide. Service provide like hotel booking , tour booking, fight booking and etc. Make my Trip is work on B2C  model. It is very beneficial for the Provider as well as User. Advantage of this application is Value-Added Services ,time saving , technical support ,24/7 Accessibility and etc. Follow the program.



==> Technology Stack

- Frontend Technology & Framework:
  Flutter, Dart
- Backend Technology & Framework: 
  Firebase, NodeJS
- Project architecture:
  Clean architecture, with separation of presentation, data and domain layer
- Project VCS:
  GitHub



                                      ---------- FrontEndSide -----------

==> Screen wise technical flow:

1. Splash screen
     * Technical Logic
        - Show splash screen till 3 seconds.
        
        
2. Intro Page
        - It’s a simple page with redirection
        - This will be customised as per the UI/UX
        - It will comprise of images, content and videos.
        
        
3. Login Page
     * Technical Logic

	    1. LogIn with social Media
        - On click of google login, call googleLogin method from bloc and login user via google Login and in that user FirebaseAuth to authenticate user.
        - On click of Facebook login, call Facebook Login method from bloc and login user via Facebook Login and in that user FirebaseAuth to                       authenticate user.
        - Once user is loggedIn,
        - update isLoggedIn value to true in share preference 
        - check if the user exists in User model in database. If it is not then save userdata in database.

	    2. LogIn with  Credentials
        - shows two field email id and password
        - Check if the user exists in User model in database. If it is there then store id of user in shared preference

 	    3. Sign up redirect link
        - On click of signup link,redirect to the sign up page
        
        
        
        
4. Sign up Page
       * Technical Logic

	       1. Credentials Signup
            - Shows the fields like Full name, Email,Phone number,Password and Confirm Password  for input user data
            - Check if the user exists in User model in database. If it is there then show error that user is already loggedIn otherwise store the                     data.

 	       2. login redirect link
            - On click of login link,redirect to the login page
	

5. Home Page
        * Technical Logic

	       1. Access for Visitor/Registered User
               	    * Features
                	- state tour 
                	- place tour
                	- hotels booking
                    * popular hotels
                	- shows the list of hotels based on ratings.
                    * Tab bar
                	- Home
                	- My Trips
                	- Favourite Hotel
                	- Profile
                    * Others
                	- This will be customised as per the UI/UX

		
6. Search hotel page
        * Technical Logic

            - Location field
            - Date field (check In – check Out) , Select using the calendar.
            - Select rooms field


7. Hotels list page
        * Technical Logic

            1. App bar
              - Edit search hotel details
              - search bar for address
              - filter for hotels
              
            2. List of hotel list
              - show card of hotel detail



8. View Hotel Details Page
        * Technical Logic

            1. Image View
            2. Information of Hotels
            3. Hotel Confirmation Button



9. Select Room Page
        * Technical Logic

            1. Different Category Room with more details about the foods and etc.
            2. Confirmation Button/ Payment Button.
            3. Other will be customised as per the UI/UX


10.  Payment Page
        * Technical Logic

            1. Static Page.




                  			                  ---------- BackEndSide -----------




==> Screen wise technical flow:

1. Home page
	- display 4 image(famous hotel) that get from api
	- display popular tours that consist 
		1) tour name
		2) tour image
		3) tour price
		4) tour rating
		5) tour id


2. Hotel search page
	- front end give city name , checkin check out data , no of room based on display hotel that consist
		1) hotel name
		2) hotel id
		3) rating
		4) address
		5) price
		6) hotel image



3. Hotel  page
	- front end give hotel id based on display hotel that consist
		1) hotel name
		2) hotel id
		3) rating
		4) address
		5) price
		6) hotel image
		7) hotel desc
		8) location

4. select room  page
	- front end give hotel id in that page 3 api calling for deferent type room based on display room details that consist
		1) room id
		2) room type
		3) description
		4) Features
		5) price
		6) images

5.  room  page
	- front end give room id based on display room details that consist
		1) room id
		2) room type
		3) description
		4) Features
		5) price
		6) images
		
		

								---------- Figma Design -----------
								
								
==> Figma Design Link:
	https://www.figma.com/file/7x0tt8OUgCrmKL2IKd3uGK/Untitled?node-id=0%3A1

