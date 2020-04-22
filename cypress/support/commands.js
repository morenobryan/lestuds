// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
// Cypress.Commands.add("login", (email, password) => { ... })
//
//
// -- This is a child command --
// Cypress.Commands.add("drag", { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add("dismiss", { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This will overwrite an existing command --
// Cypress.Commands.overwrite("visit", (originalFn, url, options) => { ... })

Cypress.Commands.add("signUp", () => {
  const uuid = () => Cypress._.random(0, 1e6)
  const id = uuid()
  const fullName = `Test Name ${id}`
  const email = `test${id}@example.com`

  return cy.request('POST', 'http://localhost:4001/mocks/registration',
    {
      user: {
        email: email,
        full_name: fullName,
        password: 'test'
      }
    }
  )
})

Cypress.Commands.add("login", (email, password) => {
  cy.request('POST', 'http://localhost:4001/mocks/auth',
    {
      user: {
        email: email,
        password: password
      }
    }
  ).its('body.data').as('currentUser')
})

Cypress.Commands.add("signUpAndLogin", () => {
  cy.signUp().then((response) => {
    cy.login(response.body.data.email, response.body.data.password)
  })
})
