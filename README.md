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

### First-time setup

```shell
# --pull ensures you get the latest base image of Elixir
docker-compose build --pull
# To setup the database for the app environment
docker-compose run --rm app mix ecto.setup
# To install the NPM packages necessary for the frontend
docker-compose run --rm app bash -c 'cd assets && npm install'
# To setup the database for the test environment
docker-compose run --rm test mix ecto.setup
```

### Every time

```shell
docker-compose up
```

- Main app will be listening at [http://localhost:4000](http://localhost:4000)
- A file change watcher for unit tests, credo, and code formatting will be running

## Running tests

In this app, you can either run the unit tests or the integration/E2E (end-to-end) tests.

### Unit tests

When you fire up `docker-compose up`, there's already a test watcher running that will automatically
re-run the tests whenever you change a file that is related to the tests. However, if you wanna run
all the tests manually, you can use the following command:

```shell
docker-compose run --rm test mix test
```

### E2E tests

The E2E tests use [Cypress](https://www.cypress.io) as the tool. We can run the tests either
headlessly or with the interactive mode. The interactive mode opens a window with the list of tests
and allows you to open a specific test and see it running live. Then you can time-travel, inspect
individual results and many other things.

#### Headless mode

To run the tests in headless, we can use [Docker](https://www.docker.com) for that. Simply run the
following command to run all the tests:

```shell
docker-compose -f docker-compose.yml -f docker-compose.e2e.yml up --exit-code-from cypress
```

_Note_: `--exit-code-from cypress` will make sure that when the Cypress tests end, the containers
are also exited and the resulting status code is the one from Cypress.

If you want to run an **individual test**, you can run the following command:

```shell
docker-compose -f docker-compose.yml -f docker-compose.e2e.yml run --rm cypress run --spec "cypress/integration/example_spec.js"
```

_Note_: You can customize the previous command to run multiple tests at once, to run tests tagged
with a certain tag and some other things. For more info, check the
[Cypress manual](https://docs.cypress.io/guides/guides/command-line.html#cypress-run)

#### Interactive mode

Theoretically, interactive mode can be run on Docker. However, outside of Linux, we would need an
X11 server installed on the host to be able to forward the interface to the host machine. While
there
[are some solutions](https://www.cypress.io/blog/2019/05/02/run-cypress-with-a-single-docker-command/)
to this, on our tests they didn't work at all.

Therefore, to run Cypress on interactive mode, you need to run the Cypress client natively. The
Cypress client is based on Electron, which makes it cross-platform.

##### macOS first-time setup

This setup assumes you have [Homebrew](https://brew.sh) installed. After having it installed,
install the necessary dependencies with:

```shell
brew bundle
```

Then, install the Cypress bundle with:

```shell
npm install
```

##### Opening interactive mode

**Before** opening Cypress, we need to start our application server with:

```shell
docker-compose up
```

And finally, open Cypress window:

```shell
npx cypress open
```

Then you can select the test you want to run and start running and viewing them.
