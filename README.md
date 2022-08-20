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
        - Show splash screen with animation.
	
	<p align="center">
	<img src="https://user-images.githubusercontent.com/68142955/185736115-a684dd75-8871-4a05-bc28-c541b3b5a336.png" width="200" />
	</p>
        
        
2. Intro Page

        - It’s a simple page with redirection
        - It will comprise of images, content and videos.
        
	<p align="center">
	<img src="https://user-images.githubusercontent.com/68142955/185636367-8a53ef2d-7473-4b07-8c2c-972d66d52326.png" width="200" />
	<img src="https://user-images.githubusercontent.com/68142955/185636392-a8b96060-5b8a-41e8-8cb9-a0ca4776ac82.png" width="200" />
	<img src="https://user-images.githubusercontent.com/68142955/185636410-754aa289-3f8d-4ac8-bb31-c3c7d28fa3e9.png" width="200" />
	<img src="https://user-images.githubusercontent.com/68142955/185636421-156f8165-379b-41da-a358-e13cca1b5198.png" width="200" />
	</p>       

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
	
	<p align="center">
        <img src="https://user-images.githubusercontent.com/68142955/185736523-f4374b04-65ee-4067-b935-6d9ec10f455e.png" width="200" />
	</p>
	      
        
4. Sign up Page

	 1. Credentials Signup
	 
            - Shows the fields like Full name, Email,Phone number,Password and Confirm Password  for input user data
            - Check if the user exists in User model in database. If it is there then show error that user is already loggedIn otherwise store the                     data.

 	 2. login redirect link
            - On click of login link,redirect to the login page
		
	 <p align="center">   
	 <img src="https://user-images.githubusercontent.com/68142955/185736533-c5d01c68-5261-42cb-b39c-49f33a9b0f6b.png" width="200" />
	 </p>
	

5. Home Page

	       1. Access for Visitor/Registered User
               	    * Features
                	- state tour 
                	- place tour
                	- hotels booking
                    * Popular hotels
                	- shows the list of hotels based on ratings.
                    * Tab bar
                	- Home
                	- My Trips
                	- Favourite Hotel
                	- Profile
                    * Coupans 
                	- Views offer in home page 
		 
	<p align="center">		
	<img src="https://user-images.githubusercontent.com/68142955/185736594-375862da-43e4-4ec9-bcf9-f11f062e4b37.png" width="200" />
	</p>
	

		
6. Search Hotel Page
   
            - Location field
            - Date field (check In – check Out) , Select using the calendar.
            - Select rooms field
	
	<p align="center">
	<img src="https://user-images.githubusercontent.com/68142955/185737864-c5d95fd7-1fcb-4f70-8449-1e807e202ced.png" width="200" />
	<img src="https://user-images.githubusercontent.com/68142955/185737881-967afffe-9a6e-4972-8bbb-62cfd60c4348.png" width="200" />
	</p>
	

7. Hotels List Page

            1. App bar
              - Edit search hotel details
              - search bar for address
              - filter for hotels
              
            2. List of hotel list
              - show card of hotel detail
	
	<p align="center">
	<img src="https://user-images.githubusercontent.com/68142955/185736640-2dfe3781-08a2-48f4-899d-3d7ff0773b6e.png" width="200" />
	</p>


8. Hotel Details Page

            1. Gallery View
            2. Review of hotel
            3. Hotel Confirmation Button
	
	<p align="center">
	<img src="https://user-images.githubusercontent.com/68142955/185736713-c8e48996-b616-4cde-9703-7c892262cf93.png" width="200" />
	<img src="https://user-images.githubusercontent.com/68142955/185737684-5f62b6e3-cf60-49f1-896a-bc4bb4ee95d9.png" width="200" />
	<img src="https://user-images.githubusercontent.com/68142955/185738214-f0eaad6d-6b1f-42cd-8171-56d8c3175141.png" width="200" />
	<img src="https://user-images.githubusercontent.com/68142955/185738089-d70e170a-ce58-4da2-b57f-493b173df86d.png" width="200" />
	<img src="https://user-images.githubusercontent.com/68142955/185737747-997c35a2-683d-4af2-8c67-84e1afded760.png" width="200" />
	</p>


9. Room Category Page 

            1. Different Category Room with more details about the foods and etc.
            2. Confirmation Button/ Payment Button.
            3. Other will be customised as per the UI/UX
	
	<p align="center">
	<img src="https://user-images.githubusercontent.com/68142955/185736777-001cabc6-7dec-420f-8f13-6ab8100cb2ca.png" width="200" />
	</p>
	

10. Room Detail Page
	
	- Information about room of specific hotel.
	
	<p align="center">
	<img src="https://user-images.githubusercontent.com/68142955/185737645-05e207b3-e090-44d7-9309-a92ae0d821ce.png" width="200" />
	</p>
	

11. Confirmation Page
	
	<p align="center">
	<img src="https://user-images.githubusercontent.com/68142955/185737801-ceaa25bf-4011-4220-85e2-c674b406ba60.png" width="200" />
	<img src="https://user-images.githubusercontent.com/68142955/185737960-0121f054-fc3c-4841-b563-0d9a67d5c3a3.png" width="200" />
	</p>
	
	
12. Booking History Page

	<p align="center">
	<img src="https://user-images.githubusercontent.com/68142955/185738022-2d206d07-2cbb-42ac-b7b4-73e736a923fe.png" width="200" />
	</p>
	

13. Wishlist Page

	<p align="center">
	<img src="https://user-images.githubusercontent.com/68142955/185738035-6c697b8b-522b-4fd3-b7f7-5469628fb436.png" width="200" />
	</p>
	
	
14. Setting Page

	<p align="center">
	<img src="https://user-images.githubusercontent.com/68142955/185738174-bf2b9ba3-48eb-4a6b-87c2-1dc15527cd22.png" width="200" />
	<img src="https://user-images.githubusercontent.com/68142955/185738192-f458eff5-d836-4bed-aa29-bddb2e2e8529.png" width="200" />
	</p>
	

10. Payment Page

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

