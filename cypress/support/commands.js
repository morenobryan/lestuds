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

  cy.request('POST', `${Cypress.env('mock_base_url')}mocks/registration`,
    {
      user: {
        email: email,
        full_name: fullName,
        password: 'test'
      }
    }
  ).its('body.data').as('registeredUser')
})

Cypress.Commands.add("login", (email, password) => {
  cy.request('POST', `${Cypress.env('mock_base_url')}mocks/auth`,
    {
      user: {
        email: email,
        password: password
      }
    }
  ).its('body.data').as('currentUser')
})

Cypress.Commands.add("signUpAndLogin", () => {
  cy.signUp().then((yieldData) => {
    cy.login(yieldData.email, yieldData.password)
  })
})
