# StudyManager

This is a simple Study Manager, to make users life easier by removing the burden of choosing what to
study next. Just drop in what you are interested in, tell the system at which days and at what times
you are available and the system will create a study plan for you.

## Business Case

Every user creates subjects which they want to study. So for instance, if I want to study "Elixir
development", I'd put that as a subject. Those topics can have subtopics as well, so in our example
I could have "Language basics", "Functional concepts" and "Phoenix framework" as subtopics.

With those subjects, the user can also tell the system which days and what times they have available
for studying. I can say for instance that I can study on Mondays to Wednesdays from 19:00 to 20:00
and on Thursdays from 20:00 to 23:00, leaving Fridays, Saturdays and Sundays free.

After that, the user can generate a study plan to accomodate some (or all) the topics they want to
study at the days and times they want to study them. Then, the system generates a calendar view with
that study plan, specifying how those study sessions should be distributed over time.

## Local development

This app is Dockerized for development mode and its dependency services are provided via
[docker-compose]. So you'll want to install Docker before proceeding.

The fastest way to get the app server and tests running:

```shell
# first-time setup only
# --pull ensures you get the latest base image of Elixir
docker-compose build --pull
docker-compose run --rm app mix ecto.setup

# every time
docker-compose up
```

- Main app will be listening at [http://localhost:4000](http://localhost:4000)
- A file change watcher for unit tests, credo, and code formatting will be running
