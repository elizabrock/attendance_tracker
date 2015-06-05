# attendance_tracker
Cohort Huckleberry 2-day Rails Project

This is my example implementation, based on the instructions that the class was given.

## Instructions

1. No authentication
2. Users should be able to enter "planned absences" (future dates)
3. Users cannot enter past attendance records
4. Display attendance leadersboard
5. Write tests!
6. Wireframe it!

## Project Setup

* Ruby Version: 2.2.2
* System Dependencies: Postgresql

### First Time

1. `bundle`
2. Copy `config/database.yml.example` to `config/database.yml`
3. Modify `config/database.yml` to match any particular settings necessary for your development environment
4. Run `rake db:create:all`
5. Run `rake db:migrate`
5. Run `rake db:seed`
6. Run `rake`

At the end of this process, `rake` should pass.

### Subsequently

1. `git pull`
2. `rake db:migrate`
3. `rake`
