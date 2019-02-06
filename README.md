Davyjones
================
A running Diary of my app development on Davy Jones Lockers:

*Locker Storage Coding Exercise*

Instructions: The exercise can be completed in the language of your choice. Please submit solutions in a zip file or as a
	Git repo we can access. The exercise could take 2-3 hours to complete. Please document any
	assumptions made while completing the exercise.

Exercise: Write a program for managing locker reservations at a hotel concierge desk. Customers leave bags with
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
6. Unless this is getting a Lot more complicated, the concierge will be the responsible party for determining the appropriate size locker, not my program. 

Phase 1: Bouncing ideas for a locker assignment & ticketing system off my wife: 

1. Me: "It prints lyrics you have to sing to get your bags back"
	
Jen: "what if you don't know the tune?"

Me: "it prints the music too"

Jen: "then you have to be able read music"

Me: "...iiiit can play the song for you when you check in"

Jen: "To hard to remember when you're drunk"

Me: "you win. next"

2. Jen: "It snaps a pic of your face & caricatures you for the print"

Me: "cameras, megabytes, and privacy oh my! too hard. I love it, but i only have 3 hours. next"

3. Me: "Lucky Locker: a slot machine interface where you input your ticket number or locker size & if your's is the lucky locker number for the night you win a prize!"

Jen: "Kinda fun, but we can do better... Lockers... what about keys? The birds & the Keys? Florida Keys? Law Kers. Lalala... "

4. Me: "Davy Jones (Locker!) It generates a pirate name for you, and prints it on the card. Stretch goals: pirate caricatures of your face & swashbuckling tunes. Super stretch goal: One lucky number a week wins a bottle o'Rum!" 

Manager: 'Johny, take these good people down to Davy Jones Locker.'

Johny: 'What?'

Manager: 'Our concierge Johny.'

Johny: 'Oh, right.'
	
Jen: "Sold."

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

Ready, Set, Red-Green-Refactor? Okay, so writing feature specs seems like overkill for an exercise, but then again, Skiplist's whole shtick is thoughtful software right? Am I being more thoughtful by understanding its just an exercise, and not over-engineering it, or does that just present myself as lazy? I'm going to assume you thought of this, and added the 2-3 hour guideline as parameter, indicating that you don't care THAT much about the code quality for this exercise. (Which I'm kind of disappointed about, because one of my favorite things is wrestling with understanding a problem, and weighing the pros & cons of solutions to it) 

That said, I think Davy needs to know a couple things: 1. A locker's availability status, and 2. a locker's size. That's basically it for our data architecture. I'm going to present the concierge with available options in each size, and when they select one, I'll "print" the ticket, update the db, & refresh the view.(and of course add pirate names)

In the vein of getting something up and working quickly, I think I'll dust off RoR, and use the composer gem.

Phase 3. Ready-Set-Scaffold!

Rails composer

Rails g scaffold Locker name:string is_available:boolean

db:seed x3000

NOOOO, the Faker gem doesn't have a pirate name library! I'm devastated. I'm hand seeding 10 pirate names for this thing until we find a good api, and definitely submitting an issue requesting an update.

db & Heroku creations, seeds, & migrations

Voila! After only a few bugs, the app is live, and has a db of lockers. Architecture: check. Deployment: check. Finally time to write some code.
 
doh. I forgot to include the locker size in the model; rails g migration add_size_to_lockers size:string, etc

Since the test suite only has rspec's smoke test, I commented the primary steps I took to write the application behavior necessary for our use case below. If you search the repo for these comments, you can pretty much step through my process:

I started by allowing a concierge to "print" a ticket by clicking on one of the displayed 'available' lockers.

/ 1. get available lockers

/ 2. display buttons to accept concierge input & start the receiving workflow. 

When a ticket is "printed", I change the locker's status from available to unavailable, update the list of available lockers, and refresh the page.

/ 3. Update the locker to be 'unavailable'

/ 4. "Print" ticket & show concierge locker number to put bags in

Next I created a super simple search feature so a concierge can lookup a locker by name

/ 5. Start the retrieval work flow by taking the locker name from the concierge

/ 6. get the requested locker with that ticket name

/ 7. Show the locker number after a successful search

Finally, I gave the concierge the ability to change a locker from unavailable to available next to the search result. 

/ 8. allow a concierge to ^update it when bags are returned to owners

/ 9. Update locker to be 'available' again


This application requires:

- Ruby 2.5.0
- Rails 5.2.1

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

If you want your own deployment, edit the app.json file to point to your own repo, then click the button below. (you may have to work around Heroku's love/hate relationship with Bundler though).

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)
