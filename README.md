Davyjones
================
A running Diary of my app development on Davy Jones Lockers:

*Locker Storage Coding Exercise*
Instructions
	The exercise can be completed in the language of your choice. Please submit solutions in a zip file or as a
	Git repo we can access. The exercise could take 2-3 hours to complete. Please document any
	assumptions made while completing the exercise.
Exercise
	Write a program for managing locker reservations at a hotel concierge desk. Customers leave bags with
	the concierge, who then uses your program to determine in which locker to place the bag. The program
	tells the concierge the number of the locker in which to place the bag and prints a ticket to give to the
	customer. Upon return, the customer provides the ticket, and the concierge uses that to look up the
	corresponding locker, retrieve the bag, and return it to the Customer.
	There are 1000 small lockers, 1000 medium-­­sized lockers, and 1000 large lockers (it’s a big Vegas
	hotel). You can assume that all checked bags fit into one of these three sizes. The program should
	always assign the smallest available locker that fits the bag.

Assumptions: 
1. When you said to print a ticket, what you really meant was to *pretend* to print a ticket. 
2. Our concierges are flawless gifts from God, who Never make mistakes.
3. Our customers never lose their tickets
4. Since we only have 3000 lockers, we really don't give a hoot about how performant the code is.
5. Since we don't care about performance, *I* assume that the most important question to answer here is "how can I make a bag check fun?"
6. My only real constraint is the guideline of a 2-3 hour timebox
7. Unless this is getting a Lot more complicated, the concierge will be the responsible party for determining the appropriate size locker, not my program. 

Phase 1: Ideate with Jen

ideas for a locker assignment & ticketing system: 
1.  "It prints lyrics you have to sing to get your bags back"
	"what if you don't know the tune?"
	"it prints the music too"
	"then you have to be able read music"
	"...iiiit can play the song for you when you check in"
	"To hard to remember when you're drunk"
	"you win. next"
2.  "It snaps a pic of your face & caricatures you for the print"
	"cameras, megabytes, and privacy oh my! too hard. I love it, but i only have 3 hours. next"
3.  "Lucky Locker: a slot machine interface where you input your ticket number or locker size & if your's is the lucky locker number for the night you win a prize!"
	"Kinda fun, but we can do better... Lockers... what about keys? The birds & the Keys? Florida Keys? Law Kers. Lalala... "
4.  "Davy Jones (Locker!) It generates a pirate name for you, and prints it on the card. Stretch goals: pirate caricatures of your face & swashbuckling tunes. Super stretch goal: One lucky number a week wins a bottle o'Rum!" 
		Manager: 'Johny, take these good people down to Davy Jones Locker.'
		Johny: 'What?'
		Manager: 'Our concierge Johny.'
		Johny: 'Oh, right.'
	"Sold."

Ok, we've got a winner, now my thoughts go to... 

Phase 2. designing the behavior of the application

I think we've got 2 workflows: 1 for receiving bags & another for returning bags. We've assumed concierge will be determining & entering sizes. That's enough to kickoff the receiving flow.
	receiving flow
		1. Take user input for size
		2. Analyze locker availability(probably want a state machine to save resources)
		3. Return an available locker
		4. Set locker status to occupied
		5. "Print" the ticket & trade it for their bags
	retrieving flow
		1. Take user input for ticket name
		2. return locker number 
		3. reset locker status to unoccupied
		4. return their bags

Ready, Set, Red-Green-Refactor? haha, yeah right. I've got 3, no, ~2.25 hours remaining. Buuuut your whole shtick is thoughtful software right? it strikes me - as I'm sitting here weighing whether or not to write any tests - that perhaps a company who claims to value thoughtful software should remove the time guideline for its introductory exercise. If an applicant chooses not to spend said time notating their thought process because they'd rather spend it building things that demonstrate their skills, you would be left guessing at just how thoughtful they had been. So I'll assume you thought of that, and added the 2-3 hour guideline anyway, indicating that you don't care that much about the code quality for THIS exercise. (Which I think is kind of a shame, because there are probably some interesting ideas to digest around designing a system that checks conditional statuses & needs to be able to determine which objects are available despite being able to be reset in any possible order. I'll put a pin in it, and if I get around to refactoring I'll think it through more thoroughly) 

I think Davy needs to know a couple things: 1. A locker's availability status, and 2. a locker's size. That's basically it for our data architecture. I'm going to present the concierge with available options in each size, and when they select them, "print" the ticket, update the db, & refresh the view.(and of course add pirate names)

No idea how to do this in the remaining amount of time without some mad framework help. Its been awhile, so I'll dust off RoR, and use the composer gem.

Phase 3. Ready-Set-Scaffold!
	Rails composer
	Rails g scaffold Locker name:string is_available:boolean
	db:seed x3000
	 NOOOO, the Faker gem doesn't have a pirate name library! I'm devastated. I'm hand seeding 10 pirate names for this thing until we find a good api, and definitely submitting an issue requesting an update.
	db & Heroku creations & migrations

Voila! After only a few bugs, the app is up, and has a db of lockers. Architecture: check. Deployment: check. Finally time to write some code.
 
doh. I forgot to include the locker size in the model.
	rails g migration add_size_to_lockers size:string

Since I only wrote a smoke test, I commented the primary steps I took to get the application behavior necessary for our use case below:

I started by allowing a concierge to "print" a ticket by clicking on one of the displayed 'available' lockers.
    # 1. get available lockers
	/ 2. display buttons to accept concierge input & start the receiving workflow. 
When a ticket is "printed", I change the locker's status from available to unavailable, update the list of available lockers, and refresh the page.
	/ 3. Update the locker to be 'unavailable'
	/ 4. "Print" ticket & show concierge locker number to put bags in
Next I created a super simple search feature so a concierge can lookup a locker by name
	/ 5. Start the retrieval work flow by taking the locker name from the concierge
	# 6. get the requested locker with that ticket name
	/ 7. Show the locker number after a successful search
Finally, I gave the concierge the ability to change a locker from unavailable to available next to the search result. 
	/ 8. allow a concierge to ^update it when bags are returned to owners
	/ 9. Update locker to be 'available' again

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

This application was generated with the [rails_apps_composer](https://github.com/RailsApps/rails_apps_composer) gem
provided by the [RailsApps Project](http://railsapps.github.io/).

Rails Composer is supported by developers who purchase our RailsApps tutorials.

Ruby on Rails
-------------

This application requires:

- Ruby 2.5.0
- Rails 5.2.1

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).


-------------