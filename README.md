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
        - Show splash screen till 3 seconds.
	
	Image: https://user-images.githubusercontent.com/68142955/185636064-ded11d04-aaee-4c7a-aeb7-7764c84c1700.png

        
        
2. Intro Page
        - It’s a simple page with redirection
        - This will be customised as per the UI/UX
        - It will comprise of images, content and videos.
        
	Image: [intro1](https://user-images.githubusercontent.com/68142955/185636367-8a53ef2d-7473-4b07-8c2c-972d66d52326.png)
	       [intro2](https://user-images.githubusercontent.com/68142955/185636392-a8b96060-5b8a-41e8-8cb9-a0ca4776ac82.png)
	       [intro3](https://user-images.githubusercontent.com/68142955/185636410-754aa289-3f8d-4ac8-bb31-c3c7d28fa3e9.png)
	       [intro4](https://user-images.githubusercontent.com/68142955/185636421-156f8165-379b-41da-a358-e13cca1b5198.png)
	       

3. Login Page

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
	
        
	Image: https://user-images.githubusercontent.com/68142955/185636922-27a0f384-ee7e-4dc8-a228-f9a8d8199951.png

        
        
4. Sign up Page

	 1. Credentials Signup
	 
            - Shows the fields like Full name, Email,Phone number,Password and Confirm Password  for input user data
            - Check if the user exists in User model in database. If it is there then show error that user is already loggedIn otherwise store the                     data.

 	 2. login redirect link
            - On click of login link,redirect to the login page
	    
	 Image: https://user-images.githubusercontent.com/68142955/185637046-4680a2ae-d086-4f3c-8d3c-4baaebbfd0c3.png

	

5. Home Page

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
			
			
	Image: https://user-images.githubusercontent.com/68142955/185637316-10651a23-4762-4264-9b60-edbbcbda2e0b.png


		
6. Search hotel page
   
            - Location field
            - Date field (check In – check Out) , Select using the calendar.
            - Select rooms field
	    
	Image: 


7. Hotels list page

            1. App bar
              - Edit search hotel details
              - search bar for address
              - filter for hotels
              
            2. List of hotel list
              - show card of hotel detail
	      
	Image: https://user-images.githubusercontent.com/68142955/185644679-2df1a112-57c4-46f5-bdf7-edd2a403a023.png



8. View Hotel Details Page

            1. Image View
            2. Information of Hotels
            3. Hotel Confirmation Button
	    
	Image: https://user-images.githubusercontent.com/68142955/185644777-54c4807f-6521-4e8e-8220-dfe065a73106.png



9. Select Room Page

            1. Different Category Room with more details about the foods and etc.
            2. Confirmation Button/ Payment Button.
            3. Other will be customised as per the UI/UX
	    
	Image: https://user-images.githubusercontent.com/68142955/185645010-8af57f19-b447-4d69-badc-fc9b3ca76de2.png



10.  Payment Page

            1. Razorpay Integeration.




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

