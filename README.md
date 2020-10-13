Author: Garett Friesen
# Rails Punch Clock & Scheduler

A local non-profit was looking to have their volunteer schedules put online, and they also needed a way to track when their volunteers started and ended their shift.

And I needed to get better at Ruby on Rails, so I developed a Ruby on Rails based staff scheduler and punch clock all-in-one!

## Features
- Full Month Calendar View
  - Users can view their shifts on an actual calendar view!
- Role/Session Based Authentication
  - You can create users with different roles to allow or deny access to parts of the website
  - Sessions tokens are used to validate that there is an authenticated user logged in
- Dedicated Punch Clock View
  - The punch clock is defined as a user with it's own role
  - It is set up for use on a dedicated tablet or laptop
- Manage both Users, Shifts and Punches
  - View and manage your users from a single page!
  - Punch in's and out's are logged to help keep on track

## Features Missing (but considered!)😢
- Email Notifications
- Nicer Styling 😔
- Punching in/out via staff number, rather than email

## Default Logins
Default logins are generated with `rails db:seed`. Edit the `db/seeds.rb` file as needed.

The Punch Clock view is meant to be used on some sort of dedicated device.

To log out of the Punch Clock view, change the url route to `/logout` and submit:

`localhost:3000/punchclock -> localhost:3000/logout`